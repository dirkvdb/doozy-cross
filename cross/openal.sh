#!/bin/bash
MAJOR=1
MINOR=16
REVISION=0
NAME=openal-soft
PACKAGE=${NAME}-${MAJOR}.${MINOR}.${REVISION}
CURPATH=`pwd`

function checkresult {
    "$@"
    local status=$?
    if [ $status -ne 0 ]; then
        echo "error with $@ status=$status" >&2
		exit $status
    fi
    return $status
}

checkresult wget "http://www.openal-soft.org/openal-releases/${PACKAGE}.tar.bz2"
checkresult tar xf $PACKAGE.tar.bz2
rm -f $PACKAGE.tar.bz2

checkresult mkdir -p $PACKAGE/build
checkresult cd $PACKAGE/build && checkresult cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$CURPATH/local -DCMAKE_TOOLCHAIN_FILE=$CURPATH/toolchain-${ARMARCH}.make ../ && make -j4 install
cd ../../
rm -rf $PACKAGE

