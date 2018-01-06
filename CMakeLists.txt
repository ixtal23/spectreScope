#
# CMakeLists.txt
# spectreScope
#
# Created by Maxim Morozov on 04/01/2018.
# Copyright © 2018 Maxim Morozov. All rights reserved.
#

cmake_minimum_required(VERSION 3.10.1)

project(spectreScope CXX)

set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_SKIP_RPATH TRUE)

set(CMAKE_INSTALL_PREFIX ${CMAKE_SOURCE_DIR})
set(RUNTIME_INSTALL_DIR bin)

set (SOURCES
    src/main.cpp
)

add_executable(spectreScope ${SOURCES})

install(TARGETS spectreScope RUNTIME DESTINATION ${RUNTIME_INSTALL_DIR})
