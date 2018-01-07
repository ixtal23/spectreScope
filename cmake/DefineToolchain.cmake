#
# DefineToolchain.cmake
# spectreScope
#
# Created by Maxim Morozov on 07/01/2018.
# Copyright © 2018 Maxim Morozov. All rights reserved.
#

set(USE_CUSTOM_TOOLCHAIN 0)

if (CMAKE_HOST_UNIX)
    find_program(UNAME_PROGRAM uname /bin /usr/bin /usr/local/bin)
    if (UNAME_PROGRAM)
        execute_process(COMMAND ${UNAME_PROGRAM} -s OUTPUT_VARIABLE APPLICATION_SYSTEM_NAME OUTPUT_STRIP_TRAILING_WHITESPACE)
    else()
        message(FATAL_ERROR "Failed to define toolchain because uname not found")
    endif()
elseif (CMAKE_HOST_WIN32)
    set(APPLICATION_SYSTEM_NAME Windows)
else()
    message(FATAL_ERROR "Unsupported platform")
endif()

if (APPLICATION_SYSTEM_NAME MATCHES "Linux")
    execute_process(COMMAND ${UNAME_PROGRAM} -m OUTPUT_VARIABLE APPLICATION_INSTRUCTION_SET OUTPUT_STRIP_TRAILING_WHITESPACE)

    if (CMAKE_GENERATOR STREQUAL "Unix Makefiles")
        find_program(MAKE_PROGRAM NAMES make gmake)
        if (MAKE_PROGRAM)
            set(CMAKE_MAKE_PROGRAM ${MAKE_PROGRAM})
        else()
            message(FATAL_ERROR "Failed to define toolchain because make not found")
        endif()
    endif()

    set(APPLICATION_COMPILER gcc)

    set(USE_CUSTOM_TOOLCHAIN 1)
elseif (APPLICATION_SYSTEM_NAME MATCHES "SunOS")
    find_program(ISAINFO_PROGRAM isainfo /bin /usr/bin)
    if (ISAINFO_PROGRAM)
        execute_process(COMMAND ${ISAINFO_PROGRAM} -k OUTPUT_VARIABLE APPLICATION_INSTRUCTION_SET OUTPUT_STRIP_TRAILING_WHITESPACE)
    else()
        message(FATAL_ERROR "Failed to define toolchain because isainfo not found")
    endif()

    if (CMAKE_GENERATOR STREQUAL "Unix Makefiles")
        find_program(MAKE_PROGRAM NAMES make dmake)
        if (MAKE_PROGRAM)
            set(CMAKE_MAKE_PROGRAM ${MAKE_PROGRAM})
        else()
            message(FATAL_ERROR "Failed to define toolchain because make not found")
        endif()
    endif()

    set(APPLICATION_COMPILER SunPro)

    set(USE_CUSTOM_TOOLCHAIN 1)
else()
    # Do not use a custom toolchain.
    # CMake will define a toolchain automatically.
    set(USE_CUSTOM_TOOLCHAIN 0)
endif()

if (USE_CUSTOM_TOOLCHAIN)
    set(CMAKE_TOOLCHAIN_FILE_NAME "Toolchain-${APPLICATION_SYSTEM_NAME}-${APPLICATION_COMPILER}-${APPLICATION_INSTRUCTION_SET}.cmake")
    find_file(CMAKE_TOOLCHAIN_FILE NAMES ${CMAKE_TOOLCHAIN_FILE_NAME} PATHS cmake)
    if (CMAKE_TOOLCHAIN_FILE)
        set(CMAKE_USER_MAKE_RULES_OVERRIDE ${CMAKE_TOOLCHAIN_FILE})
    else()
        message(FATAL_ERROR "Failed to find toolchain file ${CMAKE_TOOLCHAIN_FILE_NAME}")
    endif()
endif()
