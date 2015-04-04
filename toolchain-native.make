# this one is important
SET(CMAKE_SYSTEM_NAME Darwin)
#this one not so much
SET(CMAKE_SYSTEM_VERSION 1)

SET(LIBTYPE STATIC)

SET(CMAKE_C_COMPILER clang)
SET(CMAKE_CXX_COMPILER clang++)

SET(ENV{OPENALDIR} ${CMAKE_CURRENT_LIST_DIR}/local/)

# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH ${CMAKE_CURRENT_LIST_DIR}/local/)
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

SET(ENV{PKG_CONFIG_PATH} ${CMAKE_CURRENT_LIST_DIR}/local/usr/lib/pkgconfig)
SET(ENV{PKG_CONFIG_LIBDIR} ${CMAKE_CURRENT_LIST_DIR}/local/usr/lib/pkgconfig)
SET(ENV{PKG_CONFIG_SYSROOT_DIR} ${CMAKE_CURRENT_LIST_DIR}/local/)