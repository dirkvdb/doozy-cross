SET(MAJOR 1)
SET(MINOR 4)
SET(REVISION 0)
SET(NAME libjpeg-turbo)
SET(PACKAGE ${NAME}-${MAJOR}.${MINOR}.${REVISION})

EXTERNALPROJECT_ADD(${NAME}
    URL http://sourceforge.net/projects/${NAME}/files/${VERSION}/${PACKAGE}.tar.gz/download TIMEOUT 30
    INSTALL_DIR ${CMAKE_BINARY_DIR}/local
    CONFIGURE_COMMAND <SOURCE_DIR>/configure ${CROSS_ARGS} --disable-dependency-tracking --host=${HOST} --prefix=<INSTALL_DIR> --disable-shared
)
