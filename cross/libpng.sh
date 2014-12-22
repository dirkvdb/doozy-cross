#!/bin/bash
MAJOR=1
MINOR=6
REVISION=16
NAME=libpng
PACKAGE=${NAME}-${MAJOR}.${MINOR}.${REVISION}
CURPATH=`pwd`
export CPPFLAGS="${CFLAGS} -I${CURPATH}/local/include"
export LDFLAGS="${LDFLAGS} -L${CURPATH}/local/lib"

function checkresult {
    "$@"
    local status=$?
    if [ $status -ne 0 ]; then
        echo "error with $@ status=$status" >&2
		exit $status
    fi
    return $status
}

checkresult wget "http://sourceforge.net/projects/${NAME}/files/libpng16/${MAJOR}.${MINOR}.${REVISION}/${PACKAGE}.tar.gz"
checkresult tar xvf ${PACKAGE}.tar.gz
rm -f ${PACKAGE}.tar.gz

checkresult cd ${PACKAGE} \
	&& checkresult ./configure --host=arm-linux-gnueabi --disable-shared --prefix=$CURPATH/local \
	&& checkresult make -j4 install
cd ..
rm -rf ${PACKAGE}

