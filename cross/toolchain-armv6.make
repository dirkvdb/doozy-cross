# this one is important
SET(CMAKE_SYSTEM_NAME Linux)
#this one not so much
SET(CMAKE_SYSTEM_VERSION 1)

#SET(LIBTYPE STATIC)
SET(CROSS /opt/x-tools6h/arm-unknown-linux-gnueabihf/bin/arm-unknown-linux-gnueabihf-)
#SET(CROSS arm-linux-gnueabihf-)

SET(CMAKE_C_COMPILER ${CROSS}gcc)
SET(CMAKE_CXX_COMPILER ${CROSS}g++)
SET(CMAKE_LINKER ${CROSS}ld)
SET(CMAKE_NM ${CROSS}nm)
SET(CMAKE_OBJDUMP ${CROSS}objdump)
SET(CMAKE_RANLIB ${CROSS}ranlib)
SET(CMAKE_STRIP ${CROSS}strip)

SET(CMAKE_C_FLAGS "-march=armv6j -mfpu=vfp -mfloat-abi=hard -marm -O3")
SET(CMAKE_CXX_FLAGS "-march=armv6j -mfpu=vfp -mfloat-abi=hard -marm -O3 -std=c++11")

SET(ENV{OPENALDIR} ${CMAKE_CURRENT_LIST_DIR}/local/)

# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH ${CMAKE_CURRENT_LIST_DIR}/local/)
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

SET(ENV{PKG_CONFIG_PATH} ${CMAKE_CURRENT_LIST_DIR}/local/lib/pkgconfig)
SET(ENV{PKG_CONFIG_LIBDIR} ${CMAKE_CURRENT_LIST_DIR}/local/lib/pkgconfig)
SET(ENV{PKG_CONFIG_SYSROOT_DIR} ${CMAKE_CURRENT_LIST_DIR}/local/)
