#
# Toolchain-SunOS-SunPro-amd64.cmake
# spectreScope
#
# Created by Maxim Morozov on 07/01/2018.
# Copyright © 2018 Maxim Morozov. All rights reserved.
#

set(CMAKE_SYSTEM_NAME SunOS)

set(CMAKE_CXX_COMPILER CC)

set(CMAKE_CXX_FLAGS_INIT                "-xarch=sse2 -m64 -errwarn=%all")
set(CMAKE_CXX_FLAGS_DEBUG_INIT          "-O0 -g0")
set(CMAKE_CXX_FLAGS_RELEASE_INIT        "-O3")
set(CMAKE_CXX_FLAGS_MINSIZEREL_INIT     "-O3")
set(CMAKE_CXX_FLAGS_RELWITHDEBINFO_INIT "-O3 -g0")

set(CMAKE_CXX_COMPILE_OPTIONS_PIC "-KPIC")
