#!/bin/bash
#
# build.sh
# spectreScope
#
# Created by Maxim Morozov on 04/01/2018.
# Copyright © 2018 Maxim Morozov. All rights reserved.
#

BUILD_HOME=$(pwd)
BUILD_CMAKE_HOME=${BUILD_HOME}/cmake.build

# CMake supports the build types: Debug, Release, MinSizeRel, RelWithDebInfo.
BUILD_TYPE=Release

rm -rf ${BUILD_CMAKE_HOME}
mkdir -p ${BUILD_CMAKE_HOME}

pushd ${BUILD_CMAKE_HOME} >/dev/null

cmake -DCMAKE_BUILD_TYPE=${BUILD_TYPE} ${BUILD_HOME}
EXIT_CODE=$?
if [[ $EXIT_CODE -eq 0 ]]; then
    make
    EXIT_CODE=$?
    if [[ $EXIT_CODE -eq 0 ]]; then
        make install
        EXIT_CODE=$?
        if [[ $EXIT_CODE -ne 0 ]]; then
            echo "ERROR: Make install failed with exit code $EXIT_CODE"
        fi
    else
        echo "ERROR: Make failed with exit code $EXIT_CODE"
    fi
else
    echo "ERROR: CMake failed with exit code $EXIT_CODE"
fi

popd >/dev/null

exit $EXIT_CODE
