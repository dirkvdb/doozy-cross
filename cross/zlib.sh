#!/bin/bash
MAJOR=1
MINOR=2
REVISION=8
NAME=zlib
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

checkresult wget "http://zlib.net/$PACKAGE.tar.gz"
checkresult tar xf $PACKAGE.tar.gz
rm -f $PACKAGE.tar.gz

echo ${CURPATH}
echo ${CROSS}
checkresult mkdir -p $PACKAGE/build
checkresult cd $PACKAGE/build && checkresult cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_TOOLCHAIN_FILE=$CURPATH/toolchain-${ARMARCH}.make .. \
	&& checkresult make -j4 \
	&& checkresult make DESTDIR=$CURPATH/local install
cd ../..
rm -rf $PACKAGE
# remove the shared library
rm -rf $CURPATH/local/usr/lib/libz.s*

