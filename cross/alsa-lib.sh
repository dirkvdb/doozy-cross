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
checkresult tar xf $PACKAGE.tar.bz2
rm -f $PACKAGE.tar.bz2

checkresult cd $PACKAGE \
    && checkresult ./configure --host=arm-linux-gnueabi --disable-dependency-tracking --disable-shared --disable-python --disable-rawmidi --disable-ucm --disable-alisp --with-libdl=no --disable-old-symbols --prefix=/usr --sysconfdir=/etc] \
    && checkresult make -j4 \
    && checkresult make DESTDIR=$CURPATH/alsa install 
cd ..
rm -rf $PACKAGE

# move the library and headers
cp -r $CURPATH/alsa/usr/lib/* $CURPATH/local/lib/
cp -r $CURPATH/alsa/usr/include/* $CURPATH/*local/include/
rm -rf $CURPATH/alsa/
