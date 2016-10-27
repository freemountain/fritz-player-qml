#!/bin/bash

PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../"
QT_PATH="$(dirname $(which qmake))/.."

DEP_PATH=$PROJECT_PATH/dependencies/vlc-qt
BUILD_PATH=$PROJECT_PATH/build-deps/vlc-qt

mkdir -p $BUILD_PATH
pushd $BUILD_PATH

cmake $DEP_PATH -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX:PATH=$QT_PATH
make prepare
cmake $DEP_PATH -DCMAKE_INSTALL_PREFIX:PATH=$QT_PATH
make -j8
make install
