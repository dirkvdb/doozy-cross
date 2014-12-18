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

checkresult cd $PACKAGE \
	&& checkresult ./configure --prefix=$CURPATH/local --static \
	&& checkresult make -j4 install	
cd ..
rm -rf $PACKAGE

