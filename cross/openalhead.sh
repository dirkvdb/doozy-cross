#!/bin/bash
NAME=openal-soft
PACKAGE=${NAME}-HEAD
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

checkresult wget "http://repo.or.cz/w/openal-soft.git/snapshot/HEAD.tar.gz"
checkresult tar xf HEAD.tar.gz
rm -f HEAD.tar.gz

checkresult mkdir -p $NAME/build
checkresult cd $NAME/build && checkresult cmake -DALSOFT_DLOPEN=OFF -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_TOOLCHAIN_FILE=$CURPATH/toolchain-${ARMARCH}.make .. \
	&& checkresult make -j4 \
	&& checkresult make DESTDIR=$CURPATH/local install
cd ../../
rm -rf $NAME

