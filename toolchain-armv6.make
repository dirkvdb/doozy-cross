# this one is important
SET(CMAKE_SYSTEM_NAME Linux)
#this one not so much
SET(CMAKE_SYSTEM_VERSION 1)

SET(LIBTYPE STATIC)
SET(HOST arm-linux-gnueabi)
SET(CROSS /opt/x-tools6h/arm-unknown-linux-gnueabihf/bin/arm-unknown-linux-gnueabihf-)

SET(CMAKE_C_COMPILER ${CROSS}gcc)

SET(CMAKE_C_FLAGS "-march=armv6j -mfpu=vfp -mfloat-abi=hard -marm -O3" CACHE STRING "" FORCE)
SET(CMAKE_CXX_FLAGS "-march=armv6j -mfpu=vfp -mfloat-abi=hard -marm -O3 -std=c++1y" CACHE STRING "" FORCE)
SET(CMAKE_EXE_LINKER_FLAGS_RELEASE "-s")

# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH $ENV{PKG_DIR})
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

#SET(ENV{PKG_CONFIG_PATH} ${CMAKE_CURRENT_LIST_DIR}/local/usr/lib/pkgconfig)
#SET(ENV{PKG_CONFIG_LIBDIR} ${CMAKE_CURRENT_LIST_DIR}/local/usr/lib/pkgconfig)
#SET(ENV{PKG_CONFIG_SYSROOT_DIR} ${CMAKE_CURRENT_LIST_DIR}/local/)
