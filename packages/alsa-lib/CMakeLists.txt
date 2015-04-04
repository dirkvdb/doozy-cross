SET(MAJOR 1)
SET(MINOR 0)
SET(REVISION 29)
SET(NAME alsa-lib)
SET(PACKAGE ${NAME}-${MAJOR}.${MINOR}.${REVISION})

EXTERNALPROJECT_ADD(${NAME}
    URL ftp://ftp.alsa-project.org/pub/lib/${PACKAGE}.tar.bz2 TIMEOUT 30
    INSTALL_DIR ${CMAKE_BINARY_DIR}/local
    CONFIGURE_COMMAND <SOURCE_DIR>/configure ${CROSS_ARGS} --disable-dependency-tracking --host=${HOST} --prefix=<INSTALL_DIR> --disable-shared --disable-python --disable-rawmidi --disable-ucm --disable-alisp --with-libdl=no --disable-old-symbols
)
