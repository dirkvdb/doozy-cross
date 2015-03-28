#!/bin/bash
MAJOR=1
MINOR=6
REVISION=17
NAME=libpng
PACKAGE=${NAME}-${MAJOR}.${MINOR}.${REVISION}
CURPATH=`pwd`
export CPPFLAGS="${CFLAGS} -I${CURPATH}/local/usr/include"
export LDFLAGS="${LDFLAGS} -L${CURPATH}/local/usr/lib"

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
checkresult tar xf ${PACKAGE}.tar.gz
rm -f ${PACKAGE}.tar.gz

checkresult cd ${PACKAGE} \
	&& checkresult ./configure --disable-dependency-tracking --host=${HOST} --disable-shared --prefix=/usr \
	&& checkresult make -j4 \
    && checkresult make DESTDIR=$CURPATH/local install
cd ..
rm -rf ${PACKAGE}

