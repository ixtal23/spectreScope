#
# Toolchain-Linux-gcc-x86_64.cmake
# spectreScope
#
# Created by Maxim Morozov on 07/01/2018.
# Copyright © 2018 Maxim Morozov. All rights reserved.
#

set(CMAKE_SYSTEM_NAME "Linux")

set(CMAKE_CXX_COMPILER "g++")

set(CMAKE_CXX_FLAGS_INIT                "-march=native -m64 -std=c++14 -Werror")
set(CMAKE_CXX_FLAGS_DEBUG_INIT          "-O0 -ggdb")
set(CMAKE_CXX_FLAGS_RELEASE_INIT        "-O3 -g0")
set(CMAKE_CXX_FLAGS_MINSIZEREL_INIT     "-O3 -g0")
set(CMAKE_CXX_FLAGS_RELWITHDEBINFO_INIT "-O3 -ggdb")
