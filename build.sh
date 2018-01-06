#!/bin/sh
#
# build.sh
# spectreScope
#
# Created by Maxim Morozov on 04/01/2018.
# Copyright © 2018 Maxim Morozov. All rights reserved.
#

BUILD_HOME=$(pwd)
BUILD_CMAKE_HOME=${BUILD_HOME}/cmake

BUILD_TYPE=Release

rm -rf ${BUILD_CMAKE_HOME}
mkdir -p ${BUILD_CMAKE_HOME}

pushd ${BUILD_CMAKE_HOME} >/dev/null

cmake -DCMAKE_BUILD_TYPE=${BUILD_TARGET} ${BUILD_HOME}

make
make install

popd >/dev/null
