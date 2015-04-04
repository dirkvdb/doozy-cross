# this one is important
SET(CMAKE_SYSTEM_NAME Linux)
#this one not so much
SET(CMAKE_SYSTEM_VERSION 1)

LIST(APPEND CMAKE_PROGRAM_PATH /opt/x-tools6h/arm-unknown-linux-gnueabihf/bin)

SET(LIBTYPE STATIC)
SET(HOST arm-linux-gnueabi)
SET(CROSS arm-unknown-linux-gnueabihf-)
SET(PKG_CONFIG_EXECUTABLE ${CROSS}pkg-config)

SET(CMAKE_C_COMPILER ${CROSS}gcc)
SET(CMAKE_CXX_COMPILER ${CROSS}g++)
SET(CMAKE_LINKER ${CROSS}ld)

SET(CMAKE_C_FLAGS "--sysroot=${CMAKE_BINARY_DIR}/local -march=armv6j -mfpu=vfp -mfloat-abi=hard -marm -O3" CACHE STRING "" FORCE)
SET(CMAKE_CXX_FLAGS "--sysroot=${CMAKE_BINARY_DIR}/local -march=armv6j -mfpu=vfp -mfloat-abi=hard -marm -O3 -std=c++1y" CACHE STRING "" FORCE)

# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH ${PKG_DIR})
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

#SET(ENV{PKG_CONFIG_PATH} ${CMAKE_CURRENT_LIST_DIR}/local/usr/lib/pkgconfig)
#SET(ENV{PKG_CONFIG_LIBDIR} ${CMAKE_CURRENT_LIST_DIR}/local/usr/lib/pkgconfig)
#SET(ENV{PKG_CONFIG_SYSROOT_DIR} ${CMAKE_CURRENT_LIST_DIR}/local/)
