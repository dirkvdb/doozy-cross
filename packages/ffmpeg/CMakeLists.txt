SET(MAJOR 2)
SET(MINOR 6)
SET(REVISION 1)
SET(NAME ffmpeg)
SET(PACKAGE ${NAME}-${MAJOR}.${MINOR}.${REVISION})

IF (CMAKE_CROSSCOMPILING)
    SET(TARGETSETTING --target-os=linux)
    SET(COMPSETTING --enable-cross-compile --arch=armel --enable-armv6 --cc=${CMAKE_C_COMPILER} --ar=${CMAKE_AR} --ranlib=${CMAKE_RANLIB})
ELSE ()
    SET(TARGETSETTING)
    SET(COMPSETTING --cc=${CMAKE_C_COMPILER} --arch=x86_64 --disable-iconv)
ENDIF ()

EXTERNALPROJECT_ADD(${NAME}
    URL http://www.ffmpeg.org/releases/${PACKAGE}.tar.bz2 TIMEOUT 30
    INSTALL_DIR ${CMAKE_BINARY_DIR}/local
    CONFIGURE_COMMAND <SOURCE_DIR>/configure ${TARGETSETTING} ${COMPSETTING} --prefix=<INSTALL_DIR> --disable-shared --disable-avdevice --disable-doc --disable-htmlpages --disable-manpages --disable-programs
        --disable-encoders --disable-muxers --disable-decoders --disable-swscale
        --enable-gpl --enable-network
        --disable-everything
        --enable-protocol=http
        --enable-decoder=aac
        --enable-decoder=alac
        --enable-decoder=ac3
        --enable-decoder=flac
        --enable-decoder=mp3
        --enable-decoder=wmav1
        --enable-decoder=wmav2
        --enable-decoder=wmalossless
        --enable-decoder=wmapro
        --enable-decoder=pcm_u8
        --enable-decoder=pcm_s8
        --enable-decoder=vorbis
        --enable-parser=ac3
        --enable-parser=aac
        --enable-parser=aac_latm
        --enable-parser=flac
        --enable-parser=mpegaudio
        --enable-parser=vorbis
        --enable-demuxer=aac
        --enable-demuxer=ac3
        --enable-demuxer=eac3
        --enable-demuxer=flac
        --enable-demuxer=mp3
        --enable-demuxer=mpc
        --enable-demuxer=wav
        --enable-demuxer=pcm_u8
        --enable-demuxer=pcm_s8
        --enable-demuxer=xwma
        --enable-demuxer=mov
        --enable-bsf=aac_adtstoasc
)
