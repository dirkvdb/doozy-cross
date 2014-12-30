#!/bin/bash
MAJOR=1
MINOR=3
REVISION=1
NAME=libjpeg-turbo
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

checkresult wget "http://downloads.sourceforge.net/project/${NAME}/${MAJOR}.${MINOR}.${REVISION}/${PACKAGE}.tar.gz"
checkresult tar xf ${PACKAGE}.tar.gz
rm -f ${PACKAGE}.tar.gz

checkresult cd $PACKAGE \
	&& checkresult autoreconf --force --install \
	&& checkresult ./configure --disable-dependency-tracking --host=${HOST} --disable-shared --prefix=/usr \
	&& checkresult make -j4 \
    && checkresult make DESTDIR=$CURPATH/local install

cd ..
rm -rf ${PACKAGE}

