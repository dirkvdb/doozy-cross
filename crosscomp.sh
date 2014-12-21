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

if [ "$#" -ne 1 ]; then
    echo "No toolchain provided"
    exit 1
fi

if [ "$1" = "archarmv6" ]; then
    export ARMARCH=armv6
    export PATH="/opt/x-tools6h/arm-unknown-linux-gnueabihf/bin:$PATH"
    export CROSS=arm-unknown-linux-gnueabihf-
elif [ "$1" = "archarmv7" ]; then
    export ARMARCH=armv7
    export PATH="/opt/x-tools7h/arm-unknown-linux-gnueabihf/bin:$PATH"
    export CROSS=arm-unknown-linux-gnueabihf-
elif [ "$1" = "macv6" ]; then
    export ARMARCH=armv6
    export PATH="/usr/local/linaro/arm-linux-gnueabihf-raspbian/bin/:$PATH"
    export CROSS=arm-linux-gnueabihf-
else
    echo "Unknown toolchain provided: $1"
    exit 1
fi

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
