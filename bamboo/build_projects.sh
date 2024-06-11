#!/bin/bash

BIN_DIR="BIN"
BUILD_DIR="build"

if [ -d "$BIN_DIR" ]; then
    rm -Rf "$BIN_DIR"
fi

if [ -d "$BUILD_DIR" ]; then
    rm -Rf "$BUILD_DIR"
fi

cd source/App
for i in $(ls -d */); do
    cd ${i%%/};
    echo "\nChange directory: $(pwd)"
    make clean
    qmake && make -j4
    cd ..
done
