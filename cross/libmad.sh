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

checkresult cd $PACKAGE \
	&& ./configure --disable-dependency-tracking --host=arm-linux-gnueabi --enable-fpm=arm --disable-shared --prefix=/usr \
	&& checkresult make -j4 \
    && checkresult make DESTDIR=$CURPATH/local install
cd ..
rm -rf $PACKAGE
cp mad.pc $CURPATH/local/usr/lib/pkgconfig/

