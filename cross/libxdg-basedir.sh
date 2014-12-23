#!/bin/bash
MAJOR=1
MINOR=2
REVISION=0
NAME=libxdg-basedir
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

checkresult wget "https://github.com/devnev/${NAME}/archive/${PACKAGE}.tar.gz"
checkresult tar xf $PACKAGE.tar.gz
rm -f $PACKAGE.tar.gz

checkresult cd ${NAME}-$PACKAGE \
	&& checkresult autoreconf --force --install \
	&& checkresult ./configure --disable-dependency-tracking --host=arm-linux-gnueabi --disable-shared --prefix=/usr \
	&& checkresult make -j4 \
    && checkresult make DESTDIR=$CURPATH/local install
cd ..
rm -rf ${NAME}-$PACKAGE

