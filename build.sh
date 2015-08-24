
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

if [ "$#" -eq 0 ]; then
    echo "No toolchain provided: $1. Choices: archarmv6|archarmv7|armv7musl|macv6|android|macnative|macnative32|mingw"
    exit 1
fi

pwd=`pwd`

if [ "$1" = "native" ]; then
    host=`uname`
    if [ "$host" = "Darwin" ]; then
        TOOLCHAIN=toolchain-native.make
    elif [ "$host" = "Linux" ]; then
        TOOLCHAIN=toolchain-native-linux.make
    else
        echo "Unknown host: $host"
        exit 1
    fi
elif [ "$1" = "macnative32" ]; then
    TOOLCHAIN=toolchain-native-32.make
elif [ "$1" = "archarmv6" ]; then
    TOOLCHAIN=toolchain-armv6.make
elif [ "$1" = "archarmv7" ]; then
    TOOLCHAIN=toolchain-armv7.make
elif [ "$1" = "armv7musl" ]; then
    TOOLCHAIN=toolchain-armv7musl.make
elif [ "$1" = "macv6" ]; then
    TOOLCHAIN=toolchain-armv6mac.make
elif [ "$1" = "android" ]; then
    TOOLCHAIN=toolchain-androidv7.make
elif [ "$1" = "mingw" ]; then
    TOOLCHAIN=toolchain-mingw.make
else
    echo "Unknown toolchain provided: $1. Choices: archarmv6|archarmv7|armv7musl|macv6|android|native|native32|mingw"
    exit 1
fi

CROSS=`grep SET\(CROSS ${TOOLCHAIN} | cut -d " " -f2 | sed 's/)//'`

export PKG_CONFIG_PATH=${pwd}/cross/local/lib/pkgconfig
export PKG_CONFIG_LIBDIR=${PKG_CONFIG_PATH}
export PKG_DIR=${pwd}/cross/local
export ac_cv_func_malloc_0_nonnull=yes
export ac_cv_func_realloc_0_nonnull=yes


if [ "$2" != "skipdeps" ]; then
    # cross compile dependencies
    rm -rf cross
    mkdir -p cross/local/include
    mkdir -p cross/local/lib

    cd cross
    checkresult cmake ../packages -DCMAKE_BUILD_TYPE=Debug -DCMAKE_TOOLCHAIN_FILE=../${TOOLCHAIN}
    checkresult make -j4
    cd ..
fi

# Cross Compile doozy
rm -rf build
mkdir -p build
mkdir -p out
cd build
checkresult cmake ../doozy -DSTATIC_BINARY=ON -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=${pwd}/${TOOLCHAIN} -DCMAKE_INSTALL_PREFIX=${pwd}/out/$1
checkresult make -j4
checkresult make install
${CROSS}strip -g ${pwd}/out/$1/bin/doozy

