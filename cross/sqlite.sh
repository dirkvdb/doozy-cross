#!/bin/bash
MAJOR=0
MINOR=15
REVISION=1b
NAME=sqlite
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

checkresult wget "http://www.sqlite.org/2014/${NAME}-autoconf-3080702.tar.gz"
checkresult tar xf ${NAME}-autoconf-3080702.tar.gz
rm -f ${NAME}-autoconf-3080702.tar.gz

checkresult cd ${NAME}-autoconf-3080702 \
	&& checkresult ./configure --disable-dependency-tracking --host=arm-linux-gnueabi --disable-shared --prefix=$CURPATH/local \
	&& checkresult make -j4 install	
cd ..
rm -rf ${NAME}-autoconf-3080702

