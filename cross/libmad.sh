#!/bin/bash
MAJOR=0
MINOR=15
REVISION=1b
NAME=libmad
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

checkresult wget "http://sourceforge.net/projects/mad/files/libmad/${MAJOR}.${MINOR}.${REVISION}/${PACKAGE}.tar.gz"
checkresult tar xf $PACKAGE.tar.gz
rm -f $PACKAGE.tar.gz

if [ x"${ARMARCH}" = x"native" ]; then
    FPM=64bit
else
    FPM=arm
fi

if [ x"${ARMARCH}" = x"android" ]; then
    HOST="arm-linux-gnueabi"
fi

checkresult cd $PACKAGE \
    && checkresult patch -p1 < ../libmad-0.15.1b-remove-force-mem.patch \
	&& checkresult ./configure --disable-dependency-tracking --host=${HOST} --enable-fpm=${FPM} --disable-shared --prefix=/usr \
	&& checkresult make -j4 \
    && checkresult make DESTDIR=$CURPATH/local install
cd ..
rm -rf $PACKAGE
cp mad.pc $CURPATH/local/usr/lib/pkgconfig/

