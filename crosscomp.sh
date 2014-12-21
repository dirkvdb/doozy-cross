#!/bin/bash

function checkresult {
    "$@"
    local status=$?
    if [ $status -ne 0 ]; then
        echo "error with $@ status=$status" >&2
        exit $status
    fi
    return $status
}

#export CROSS=/opt/x-tools6h/arm-unknown-linux-gnueabihf/bin/arm-unknown-linux-gnueabihf-
export ARMARCH=armv6
export PATH="/usr/local/linaro/arm-linux-gnueabihf-raspbian/bin/:$PATH"
export CROSS=arm-linux-gnueabihf-

# cross compile dependencies
cd cross
checkresult bash ./buildall.sh
cd ..

# Cross Compile doozy
rm -rf build doozy
checkresult git clone https://github.com/dirkvdb/doozy.git
cd doozy
checkresult git checkout develop
checkresult git submodule update --init --recursive
cd ..
mkdir build
cd build
checkresult cmake -DCMAKE_TOOLCHAIN_FILE=../cross/toolchain-armv6.make -DCMAKE_BUILD_TYPE=Release -DSTATIC_BINARY=ON ../doozy
checkresult make -j4
