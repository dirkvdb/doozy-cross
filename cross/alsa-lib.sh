#!/bin/bash
MAJOR=1
MINOR=0
REVISION=28
NAME=alsa-lib
PACKAGE=${NAME}-${MAJOR}.${MINOR}.${REVISION}
CURPATH=`pwd`

echo "CFLAGS: ${CFLAGS}"

function checkresult {
    "$@"
    local status=$?
    if [ $status -ne 0 ]; then
        echo "error with $@ status=$status" >&2
		exit $status
    fi
    return $status
}

checkresult wget "ftp://ftp.alsa-project.org/pub/lib/${PACKAGE}.tar.bz2"
checkresult tar xvf $PACKAGE.tar.bz2
rm -f $PACKAGE.tar.bz2

checkresult cd $PACKAGE \
	&& checkresult ./configure --host=arm-linux-gnueabi --disable-static --disable-python --disable-rawmidi --with-libdl=no --disable-old-symbols --prefix=$CURPATH/local \
	&& checkresult make -j4 install	
cd ..
rm -rf $PACKAGE

