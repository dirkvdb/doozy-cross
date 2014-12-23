#!/bin/bash
MAJOR=1
MINOR=9
REVISION=1
NAME=taglib
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

checkresult wget "http://taglib.github.io/releases/${PACKAGE}.tar.gz"
checkresult tar xf $PACKAGE.tar.gz
rm -f $PACKAGE.tar.gz

checkresult mkdir -p $PACKAGE/build
checkresult cd $PACKAGE/build && checkresult cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr -DENABLE_STATIC=ON -DCMAKE_TOOLCHAIN_FILE=$CURPATH/toolchain-${ARMARCH}.make .. \
	&& checkresult make -j4 \
	&& checkresult make DESTDIR=$CURPATH/local install
cd ../../
rm -rf $PACKAGE

