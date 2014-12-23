#!/bin/bash
MAJOR=2
MINOR=1
REVISION=0
NAME=openjpeg
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

checkresult wget "http://sourceforge.net/projects/${NAME}.mirror/files/${MAJOR}.${MINOR}.${REVISION}/${PACKAGE}.tar.gz"
checkresult tar xf ${PACKAGE}.tar.gz
rm -f ${PACKAGE}.tar.gz

checkresult mkdir -p $PACKAGE/build
checkresult cd $PACKAGE/build && checkresult cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$CURPATH/local -DBUILD_SHARED_LIBS=OFF -DCMAKE_TOOLCHAIN_FILE=$CURPATH/toolchain.make ../ && make -j4 install

cd ..
rm -rf ${PACKAGE}

