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
#UNAME=`uname`
#if [ "${UNAME}" = "Darwin" ]; then
#    CURPATH=`pwd`
#    export PATH="${CURPATH}/cross:$PATH"
#fi

if [ "$1" = "native" ]; then
    TOOLCHAIN=toolchain-native.make
    #export NASM=/opt/local/bin/nasm
    #export HOST="x86_64-apple-darwin"
elif [ "$1" = "archarmv6" ]; then
    TOOLCHAIN=toolchain-armv6.make
elif [ "$1" = "archarmv7" ]; then
    TOOLCHAIN=toolchain-armv7.make
elif [ "$1" = "macv6" ]; then
    TOOLCHAIN=toolchain-armv6mac.make
elif [ "$1" = "android" ]; then
    TOOLCHAIN=toolchain-androidv7.make
else
    echo "Unknown toolchain provided: $1. Choices: archarmv6|archarmv7|macv6|android"
    exit 1
fi

pwd=`pwd`

export PKG_CONFIG_PATH=${pwd}/cross/local/lib/pkgconfig
export ac_cv_func_malloc_0_nonnull=yes
export ac_cv_func_realloc_0_nonnull=yes

# cross compile dependencies
#rm -rf cross
#mkdir cross
#cd cross
#checkresult cmake .. -DCMAKE_TOOLCHAIN_FILE=../${TOOLCHAIN}
#checkresult make -j4
#cd ..

# Cross Compile doozy
rm -rf build
mkdir build
cd build
checkresult cmake ../doozy -DCMAKE_TOOLCHAIN_FILE=${pwd}/${TOOLCHAIN} -DPKG_DIR=${pwd}/cross/local
checkresult make -j4
#checkresult cmake -DCMAKE_TOOLCHAIN_FILE=../${TOOLCHAIN} -DCMAKE_BUILD_TYPE=Release -DSTATIC_BINARY=ON -DTESTTOOLS=ON -DPKG_DIR=${pwd}/cross ../doozy
#checkresult make -j4
#${CROSS}strip --strip-unneeded ./doozy
