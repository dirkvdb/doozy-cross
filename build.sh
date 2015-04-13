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

if [ "$1" = "clean" ]; then
    echo "Cleaning..."
    rm -rf build
    rm -rf cross
    echo "Done"
    exit 0
fi

if [ "$#" -ne 1 ]; then
    echo "No toolchain provided: $1. Choices: archarmv6|archarmv7|macv6|android|macnative|macnative32"
    exit 1
fi

# make sure the gas-preprocessor script is in the path on osx
#UNAME=`uname`
#if [ "${UNAME}" = "Darwin" ]; then
#    CURPATH=`pwd`
#    export PATH="${CURPATH}/cross:$PATH"
#fi

pwd=`pwd`

if [ "$1" = "macnative" ]; then
    TOOLCHAIN=toolchain-native.make
elif [ "$1" = "macnative32" ]; then
    TOOLCHAIN=toolchain-native-32.make
elif [ "$1" = "archarmv6" ]; then
    TOOLCHAIN=toolchain-armv6.make
elif [ "$1" = "archarmv7" ]; then
    TOOLCHAIN=toolchain-armv7.make
elif [ "$1" = "macv6" ]; then
    TOOLCHAIN=toolchain-armv6mac.make
elif [ "$1" = "android" ]; then
    TOOLCHAIN=toolchain-androidv7.make
else
    echo "Unknown toolchain provided: $1. Choices: archarmv6|archarmv7|macv6|android|macnative|macnative32"
    exit 1
fi

export PKG_CONFIG_PATH=${pwd}/cross/local/lib/pkgconfig
export PKG_CONFIG_LIBDIR=${PKG_CONFIG_PATH}
export PKG_DIR=${pwd}/cross/local
export ac_cv_func_malloc_0_nonnull=yes
export ac_cv_func_realloc_0_nonnull=yes

# cross compile dependencies
mkdir -p cross
cd cross
checkresult cmake ../packages -DCMAKE_TOOLCHAIN_FILE=../${TOOLCHAIN}
checkresult make -j1
cd ..

# Cross Compile doozy
mkdir -p build
cd build
checkresult cmake ../doozy -DCMAKE_TOOLCHAIN_FILE=${pwd}/${TOOLCHAIN}
checkresult make -j4
#${CROSS}strip --strip-unneeded ./doozy
