SET(MAJOR 1)
SET(MINOR 4)
SET(REVISION 1)
SET(NAME libjpeg-turbo)
SET(PACKAGE ${NAME}-${MAJOR}.${MINOR}.${REVISION})

IF (CMAKE_SYSTEM_NAME MATCHES "Darwin")
    SET (NASMOPT "NASM=/usr/local/bin/nasm")
ENDIF ()

EXTERNALPROJECT_ADD(${NAME}
    URL http://sourceforge.net/projects/${NAME}/files/${VERSION}/${PACKAGE}.tar.gz/download TIMEOUT 30
    INSTALL_DIR ${CMAKE_BINARY_DIR}/local
    PATCH_COMMAND patch -p1 < ${CMAKE_CURRENT_SOURCE_DIR}/musl.patch
    CONFIGURE_COMMAND <SOURCE_DIR>/configure ${CROSS_ARGS} ${NASMOPT} --disable-dependency-tracking --host=${HOST} --prefix=<INSTALL_DIR> --disable-shared
)
