#
# DefineToolchain.cmake
# spectreScope
#
# Created by Maxim Morozov on 07/01/2018.
# Copyright © 2018 Maxim Morozov. All rights reserved.
#

# Do not use a custom toolchain by default.
# CMake will define a toolchain automatically.
set(USE_CUSTOM_TOOLCHAIN 0)

if (CMAKE_HOST_UNIX)
    find_program(UNAME_PROGRAM uname /bin /usr/bin /usr/local/bin)
    if (NOT UNAME_PROGRAM)
        message(FATAL_ERROR "Failed to define toolchain because uname not found")
    endif()

    execute_process(COMMAND ${UNAME_PROGRAM} -s OUTPUT_VARIABLE APPLICATION_SYSTEM_NAME OUTPUT_STRIP_TRAILING_WHITESPACE)
elseif (CMAKE_HOST_WIN32)
    set(APPLICATION_SYSTEM_NAME "Windows")
else()
    message(FATAL_ERROR "Unsupported platform")
endif()

if (APPLICATION_SYSTEM_NAME MATCHES "Linux")
    if (CMAKE_GENERATOR STREQUAL "Unix Makefiles")
        find_program(CMAKE_MAKE_PROGRAM NAMES make gmake)
        if (NOT CMAKE_MAKE_PROGRAM)
            message(FATAL_ERROR "Failed to define toolchain because make not found")
        endif()
    endif()

    execute_process(COMMAND ${UNAME_PROGRAM} -m OUTPUT_VARIABLE APPLICATION_INSTRUCTION_SET OUTPUT_STRIP_TRAILING_WHITESPACE)

    set(APPLICATION_COMPILER "gcc")

    set(USE_CUSTOM_TOOLCHAIN 1)
elseif (APPLICATION_SYSTEM_NAME MATCHES "SunOS")
    if (CMAKE_GENERATOR STREQUAL "Unix Makefiles")
        find_program(CMAKE_MAKE_PROGRAM NAMES make dmake)
        if (NOT CMAKE_MAKE_PROGRAM)
            message(FATAL_ERROR "Failed to define toolchain because make not found")
        endif()
    endif()

    find_program(ISAINFO_PROGRAM isainfo /bin /usr/bin)
    if (NOT ISAINFO_PROGRAM)
        message(FATAL_ERROR "Failed to define toolchain because isainfo not found")
    endif()

    execute_process(COMMAND ${ISAINFO_PROGRAM} -k OUTPUT_VARIABLE APPLICATION_INSTRUCTION_SET OUTPUT_STRIP_TRAILING_WHITESPACE)

    set(APPLICATION_COMPILER "SunPro")

    set(USE_CUSTOM_TOOLCHAIN 1)
endif()

if (USE_CUSTOM_TOOLCHAIN)
    set(CMAKE_TOOLCHAIN_FILE_NAME "Toolchain-${APPLICATION_SYSTEM_NAME}-${APPLICATION_COMPILER}-${APPLICATION_INSTRUCTION_SET}.cmake")

    find_file(CMAKE_TOOLCHAIN_FILE NAMES ${CMAKE_TOOLCHAIN_FILE_NAME} PATHS cmake)
    if (NOT CMAKE_TOOLCHAIN_FILE)
        message(FATAL_ERROR "Failed to find toolchain file ${CMAKE_TOOLCHAIN_FILE_NAME}")
    endif()

    set(CMAKE_USER_MAKE_RULES_OVERRIDE ${CMAKE_TOOLCHAIN_FILE})
endif()
