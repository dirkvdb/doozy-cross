SET(MAJOR 1)
SET(MINOR 6)
SET(REVISION 18)
SET(NAME libpng)
SET(PACKAGE ${NAME}-${MAJOR}.${MINOR}.${REVISION})

EXTERNALPROJECT_ADD(${NAME}
    DEPENDS zlib
    URL http://sourceforge.net/projects/${NAME}/files/libpng16/${MAJOR}.${MINOR}.${REVISION}/${PACKAGE}.tar.gz TIMEOUT 30
    INSTALL_DIR ${CMAKE_BINARY_DIR}/local
    CONFIGURE_COMMAND <SOURCE_DIR>/configure ${CROSS_ARGS} --with-sysroot=<INSTALL_DIR> --disable-dependency-tracking --host=${HOST} --prefix=<INSTALL_DIR> --disable-shared
)
