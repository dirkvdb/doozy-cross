SET(MAJOR 1)
SET(MINOR 2)
SET(REVISION 8)
SET(NAME zlib)
SET(PACKAGE ${NAME}-${MAJOR}.${MINOR}.${REVISION})

EXTERNALPROJECT_ADD(${NAME}
    URL http://zlib.net/${PACKAGE}.tar.gz TIMEOUT 30
    INSTALL_DIR ${CMAKE_BINARY_DIR}/local
    PATCH_COMMAND patch -p0 < ${CMAKE_CURRENT_SOURCE_DIR}/noshared.patch
    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
)

IF (CMAKE_SYSTEM_NAME MATCHES "Darwin")
ExternalProject_Add_Step(${NAME} deleteso # Names of project and custom step
  COMMAND rm -f <INSTALL_DIR>/lib/libz.dylib && rm -f <INSTALL_DIR>/lib/libz.${MAJOR}.dylib && rm -f <INSTALL_DIR>/lib/libz.${MAJOR}.${MINOR}.${REVISION}.dylib
  COMMENT "Delete zlib shared library"
  DEPENDEES install
)
ELSE ()
ExternalProject_Add_Step(${NAME} deleteso # Names of project and custom step
  COMMAND rm -f <INSTALL_DIR>/lib/libz.so && rm -f <INSTALL_DIR>/lib/libz.so.${MAJOR} && rm -f <INSTALL_DIR>/lib/libz.so.${MAJOR}.${MINOR}.${REVISION}
  COMMENT "Delete zlib shared library"
  DEPENDEES install
)
ENDIF ()