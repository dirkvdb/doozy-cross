#!/bin/bash
MAJOR=2
MINOR=6
REVISION=1
NAME=ffmpeg
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

checkresult wget "https://www.ffmpeg.org/releases/${PACKAGE}.tar.bz2"
checkresult tar xf $PACKAGE.tar.bz2
rm -f $PACKAGE.tar.bz2

if [ x"${ARMARCH}" = x"native" ]; then
    TARGETSETTING=
    COMPSETTING="--cc=${CC} --arch=x86_64 --disable-iconv"
else
    TARGETSETTING=--target-os=linux
    COMPSETTING="--enable-cross-compile --arch=armel --enable-armv6 --cc=${CC} --ar=${AR} --ranlib=${RANLIB}"
fi

checkresult cd $PACKAGE \
	&& checkresult ./configure ${TARGETSETTING} ${COMPSETTING} --disable-shared \
        --disable-avdevice --disable-doc --disable-htmlpages --disable-manpages --disable-programs \
        --disable-encoders --disable-muxers --disable-decoders --disable-swscale \
        --enable-gpl --enable-network \
        --disable-everything \
        --enable-protocol=http \
        --enable-decoder=aac \
        --enable-decoder=alac \
        --enable-decoder=ac3 \
        --enable-decoder=flac \
        --enable-decoder=mp3 \
        --enable-decoder=wmav1 \
        --enable-decoder=wmav2 \
        --enable-decoder=wmalossless \
        --enable-decoder=wmapro \
        --enable-decoder=pcm_u8 \
        --enable-decoder=pcm_s8 \
        --enable-decoder=vorbis \
        --enable-parser=ac3 \
        --enable-parser=aac \
        --enable-parser=aac_latm \
        --enable-parser=flac \
        --enable-parser=mpegaudio \
        --enable-parser=vorbis \
        --enable-demuxer=aac \
        --enable-demuxer=ac3 \
        --enable-demuxer=eac3 \
        --enable-demuxer=flac \
        --enable-demuxer=mp3 \
        --enable-demuxer=mpc \
        --enable-demuxer=wav \
        --enable-demuxer=pcm_u8 \
        --enable-demuxer=pcm_s8 \
        --enable-demuxer=xwma \
        --enable-demuxer=mov \
        --enable-bsf=aac_adtstoasc \
        --prefix=/usr \
	&& checkresult make -j4 \
    && checkresult make DESTDIR=$CURPATH/local install
cd ..
rm -rf $PACKAGE


