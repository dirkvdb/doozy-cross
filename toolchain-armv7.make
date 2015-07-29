# this one is important
SET(CMAKE_SYSTEM_NAME Linux)
#this one not so much
SET(CMAKE_SYSTEM_VERSION 1)

SET(LIBTYPE STATIC)

SET(CMAKE_C_COMPILER $ENV{CROSS}gcc)
SET(CMAKE_CXX_COMPILER $ENV{CROSS}g++)
SET(CMAKE_LINKER $ENV{CROSS}ld)
SET(CMAKE_NM ${CROSS}nm)
SET(CMAKE_OBJDUMP $ENV{CROSS}objdump)
SET(CMAKE_RANLIB $ENV{CROSS}ranlib)
SET(CMAKE_STRIP $ENV{CROSS}strip)

SET(CMAKE_C_FLAGS "-march=armv7 -mcpu=cortex-a7 -mtune=cortex-a7 -mfpu=neon-vfpv4 -mvectorize-with-neon-quad -mfloat-abi=hard -O3" CACHE STRING "" FORCE)
SET(CMAKE_CXX_FLAGS "-march=armv7 -mcpu=cortex-a7 -mtune=cortex-a7 -mfpu=neon-vfpv4 -mvectorize-with-neon-quad -mfloat-abi=hard -O3 -std=c++1y" CACHE STRING "" FORCE)
SET(ENV{OPENALDIR} ${CMAKE_CURRENT_LIST_DIR}/local/)

# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH ${CMAKE_CURRENT_LIST_DIR}/local/)
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

SET(ENV{PKG_CONFIG_PATH} ${CMAKE_CURRENT_LIST_DIR}/local/usr/lib/pkgconfig)
SET(ENV{PKG_CONFIG_LIBDIR} ${CMAKE_CURRENT_LIST_DIR}/local/usr/lib/pkgconfig)
SET(ENV{PKG_CONFIG_SYSROOT_DIR} ${CMAKE_CURRENT_LIST_DIR}/local)
