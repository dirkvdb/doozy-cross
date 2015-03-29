#!/bin/bash
rm -rf local
mkdir -p local/usr/lib/pkgconfig
mkdir -p local/usr/include

if [ x"${ARMARCH}" = x"native" ]; then
    export CC=clang
    export CXX=clang++
    export CXXFLAGS="${CFLAGS} -std=c++11"
elif [ x"${ARMARCH}" != x"androidv7" ]; then
    export CC=${CROSS}gcc${POSTFIX}
    export CXX=${CROSS}g++${POSTFIX}
    export CXXFLAGS="${CFLAGS} -std=c++11"
    export CPP=${CROSS}cpp
    export RANLIB=${CROSS}ranlib
    export STRIP=${CROSS}strip
    export LD=${CROSS}ld
    export AS=${CROSS}as
    export AR=${CROSS}ar
    export ac_cv_func_malloc_0_nonnull=yes
    export ac_cv_func_realloc_0_nonnull=yes
fi

function checkresult {
    "$@"
    local status=$?
    if [ $status -ne 0 ]; then
        echo "error with $1" >&2
        exit $status
    fi
    return $status
}

checkresult bash zlib.sh
checkresult bash ffmpeg.sh

if [ x"${ARMARCH}" != x"androidv7" && x"${ARMARCH}" != x"native" ]; then
    checkresult bash alsa-lib.sh
fi

checkresult bash libmad.sh
checkresult bash libupnp.sh
checkresult bash libjpeg-turbo.sh
checkresult bash openalhead.sh
checkresult bash libpng.sh
checkresult bash flac.sh
checkresult bash taglib.sh
checkresult bash libxdg-basedir.sh
#checkresult bash sqlite.sh

