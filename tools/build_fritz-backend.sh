#!/bin/bash

PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.."
BUILD_PATH=$PROJECT_PATH/build-deps

mkdir -p $BUILD_PATH

cp -r $PROJECT_PATH/dependencies/fritz-backend $BUILD_PATH

pushd $BUILD_PATH/fritz-backend
npm install --only=production
popd
