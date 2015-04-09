SET(MAJOR 1)
SET(MINOR 2)
SET(REVISION 8)
SET(NAME zlib)
SET(PACKAGE ${NAME}-${MAJOR}.${MINOR}.${REVISION})

EXTERNALPROJECT_ADD(${NAME}
    URL http://zlib.net/${PACKAGE}.tar.gz TIMEOUT 30
    INSTALL_DIR ${CMAKE_BINARY_DIR}/local
    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
)

ExternalProject_Add_Step(${NAME} deleteso # Names of project and custom step
  COMMAND rm <INSTALL_DIR>/lib/libz.so && rm <INSTALL_DIR>/lib/libz.so.${MAJOR} && rm <INSTALL_DIR>/lib/libz.so.${MAJOR}.${MINOR}.${REVISION}
  COMMENT "Delete zlib shared library"
  DEPENDEES install
)