SET(NAME libunwind)
SET(MAJOR 1)
SET(MINOR 1)
SET(PACKAGE ${NAME}-${MAJOR}.${MINOR})

EXTERNALPROJECT_ADD(${NAME}
    URL http://download.savannah.gnu.org/releases/${NAME}/${PACKAGE}.tar.gz TIMEOUT 30
    INSTALL_DIR ${CMAKE_BINARY_DIR}/local
    CONFIGURE_COMMAND <SOURCE_DIR>/configure ${CROSS_ARGS} --disable-dependency-tracking --host=${HOST} --prefix=<INSTALL_DIR> --disable-shared
)
