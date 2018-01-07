#
# CMakeLists.txt
# spectreScope
#
# Created by Maxim Morozov on 04/01/2018.
# Copyright © 2018 Maxim Morozov. All rights reserved.
#

cmake_minimum_required(VERSION 2.8)

if (DEFINED CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE ${CMAKE_BUILD_TYPE} CACHE STRING "Select the build type: Debug, Release, MinSizeRel, RelWithDebInfo.")
else()
    set(CMAKE_BUILD_TYPE Release CACHE STRING "Select the build type: Debug, Release, MinSizeRel, RelWithDebInfo.")
endif()

include(cmake/DefineToolchain.cmake)

project(spectreScope CXX)

set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_SKIP_RPATH TRUE)
set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
set(CMAKE_INSTALL_PREFIX ${CMAKE_SOURCE_DIR})

set(APPLICATION_INSTALL_DIR bin)
set(APPLICATION_SOURCE_DIR src)
set(APPLICATION_SOURCES ${APPLICATION_SOURCE_DIR}/main.cpp)

add_executable(${PROJECT_NAME} ${APPLICATION_SOURCES})

install(TARGETS ${PROJECT_NAME} RUNTIME DESTINATION ${APPLICATION_INSTALL_DIR})
