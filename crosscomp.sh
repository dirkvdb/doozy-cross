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
    echo "No toolchain provided. Choices: archarmv6|archarmv7|macv6|android|native"
    exit 1
fi

# make sure the gas-preprocessor script is in the path on osx
UNAME=`uname`
if [ "${UNAME}" = "Darwin" ]; then
    CURPATH=`pwd`
    export PATH="${CURPATH}/cross:$PATH"
fi

if [ "$1" = "native" ]; then
    export ARMARCH=native
    export CFLAGS="-march=x86-64 -O3"
    #export POSTFIX="-mp-4.9"
    export NASM=/opt/local/bin/nasm
    export HOST="x86_64-apple-darwin"
elif [ "$1" = "archarmv6" ]; then
    export ARMARCH=armv6
    export PATH="/opt/x-tools6h/arm-unknown-linux-gnueabihf/bin:$PATH"
    export CROSS=arm-unknown-linux-gnueabihf-
    export CFLAGS="-march=armv6j -mfpu=vfp -mfloat-abi=hard -marm -O3"
    export HOST="arm-linux-gnueabi"
elif [ "$1" = "archarmv7" ]; then
    export ARMARCH=armv7
    export PATH="/opt/x-tools7h/arm-unknown-linux-gnueabihf/bin:$PATH"
    export CROSS=arm-unknown-linux-gnueabihf-
    export CFLAGS="-march=armv7-a -mfpu=vfpv3 -mfloat-abi=hard -O3"
    export HOST="arm-linux-gnueabi"
elif [ "$1" = "macv6" ]; then
    export ARMARCH=armv6
    export PATH="/usr/local/linaro/arm-linux-gnueabihf-raspbian/bin/:$PATH"
    export CROSS=arm-linux-gnueabihf-
    export CFLAGS="-march=armv6j -mfpu=vfp -mfloat-abi=hard -marm -O3"
    export HOST="arm-linux-gnueabi"
elif [ "$1" = "android" ]; then
    export ARMARCH=androidv7
    TOOLCHAIN="/Users/dirk/android-toolchain"
    export SYSROOT="$TOOLCHAIN/sysroot"
    export PATH="$TOOLCHAIN/bin/:$PATH"
    export CROSS=arm-linux-androideabi-
    export CFLAGS="-march=armv7-a -mfloat-abi=softfp -mfpu=vfp -O3"
    export CXXFLAGS="-fexceptions -frtti -DANDROID -DBACKWARD_SYSTEM_UNKNOWN"
    export HOST="arm-linux-androideabi"
    export LDFLAGS="$LDFLAGS -march=armv7-a -Wl,--fix-cortex-a8"
else
    echo "Unknown toolchain provided: $1. Choices: archarmv6|archarmv7|macv6|android"
    exit 1
fi

export CXXFLAGS="${CFLAGS} ${CXXFLAGS} -std=c++1y"

# cross compile dependencies
cd cross
checkresult bash ./buildall.sh
cd ..

# Cross Compile doozy
rm -rf build doozy
#rm -rf build
checkresult git clone https://github.com/dirkvdb/doozy.git
cd doozy
checkresult git checkout develop
checkresult git submodule update --init --recursive
cd ..
mkdir build
cd build
checkresult cmake -DCMAKE_TOOLCHAIN_FILE=../cross/toolchain-${ARMARCH}.make -DCMAKE_BUILD_TYPE=Release -DSTATIC_BINARY=ON -DTESTTOOLS=ON ../doozy
checkresult make -j4
${CROSS}strip --strip-unneeded ./doozy
