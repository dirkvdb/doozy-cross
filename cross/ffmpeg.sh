#!/bin/bash
MAJOR=2
MINOR=5
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
checkresult tar xvf $PACKAGE.tar.bz2
rm -f $PACKAGE.tar.bz2

checkresult cd $PACKAGE \
	&& checkresult ./configure --target-os=linux --arch=armel --enable-armv6 --enable-cross-compile --disable-shared \
        --disable-avdevice --disable-doc --disable-htmlpages --disable-manpages --disable-programs \
        --disable-encoders --disable-muxers --disable-decoders \
        --enable-gpl \
        --disable-everything \
        --enable-decoder=flac \
        --enable-decoder=mp3 \
        --enable-decoder=wmav1 \
        --enable-decoder=wmav2 \
        --enable-decoder=wmavlossless \
        --enable-decoder=wmapro \
        --enable-decoder=pcm \
        --enable-decoder=vorbis \
        --enable-parser=ac3 \
        --enable-parser=aac \
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
        --prefix=$CURPATH/local \
	&& checkresult make -j4 install	
cd ..
rm -rf $PACKAGE
cp mad.pc $CURPATH/local/lib/pkgconfig/

