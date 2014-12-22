#!/bin/bash
MAJOR=1
MINOR=3
REVISION=1
NAME=flac
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

checkresult wget "http://downloads.xiph.org/releases/flac/${PACKAGE}.tar.xz"
checkresult tar xf $PACKAGE.tar.xz
rm -f $PACKAGE.tar.xz

checkresult cd $PACKAGE \
	&& checkresult ./configure --host=arm-linux-gnueabi --disable-ogg --disable-xmms-plugin --disable-shared --prefix=$CURPATH/local \
	&& checkresult make -j4 install	
cd ..
rm -rf $PACKAGE

