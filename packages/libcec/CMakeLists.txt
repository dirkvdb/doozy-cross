SET(MAJOR 3)
SET(MINOR 0)
SET(REVISION 1)
SET(NAME libcec)
SET(PACKAGE ${NAME}-${MAJOR}.${MINOR}.${REVISION})

EXTERNALPROJECT_ADD(${NAME}
    URL https://github.com/Pulse-Eight/libcec/archive/${PACKAGE}.tar.gz TIMEOUT 30
    INSTALL_DIR ${CMAKE_BINARY_DIR}/local
    PATCH_COMMAND autoreconf --force --install
    CONFIGURE_COMMAND <SOURCE_DIR>/configure ${CROSS_ARGS} --disable-dependency-tracking --host=${HOST} --enable-rpi --with-rpi-include-path=${CMAKE_CURRENT_SOURCE_DIR}/../raspifirmware/vc/include --with-rpi-lib-path=${CMAKE_CURRENT_SOURCE_DIR}/../raspifirmware/vc/lib --prefix=<INSTALL_DIR> --disable-static --enable-shared
)
