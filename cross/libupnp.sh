#!/bin/bash
MAJOR=1
MINOR=6
REVISION=19
NAME=libupnp
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

checkresult wget "http://sourceforge.net/projects/pupnp/files/pupnp/libUPnP%201.6.19/${PACKAGE}.tar.bz2"
checkresult tar xvf $PACKAGE.tar.bz2
rm -f $PACKAGE.tar.bz2

checkresult cd $PACKAGE \
	&& checkresult ./configure --host=arm-linux-gnueabi --enable-ipv6 --disable-shared --prefix=$CURPATH/local \
	&& checkresult make -j4 install	
cd ..
rm -rf $PACKAGE

