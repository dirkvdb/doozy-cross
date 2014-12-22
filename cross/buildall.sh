#!/bin/bash
rm -rf local
mkdir -p local/lib/pkgconfig
mkdir -p local/include

export CXXFLAGS="${CFLAGS} -std=c++11"
export CC=${CROSS}gcc${POSTFIX}
export CXX=${CROSS}g++${POSTFIX}
export RANLIB=${CROSS}ranlib
export STRIP=${CROSS}strip
export LD=${CROSS}ld
export AS=${CROSS}as
export AR=${CROSS}ar
export ac_cv_func_malloc_0_nonnull=yes
export ac_cv_func_realloc_0_nonnull=yes
echo ${CC}

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
checkresult bash alsa-lib.sh
checkresult bash openalhead.sh
checkresult bash libjpeg-turbo.sh
checkresult bash libpng.sh
checkresult bash libmad.sh
checkresult bash flac.sh
checkresult bash taglib.sh
checkresult bash libxdg-basedir.sh
checkresult bash libupnp.sh
#checkresult bash sqlite.sh

