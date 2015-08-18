# this one is important
SET(CMAKE_SYSTEM_NAME Linux)
#this one not so much
SET(CMAKE_SYSTEM_VERSION 1)

SET(LIBTYPE STATIC)
SET(HOST arm-linux-musleabihf)
SET(CROSS /opt/cross/arm-linux-musleabihf/bin/arm-linux-musleabihf-)

SET(CMAKE_C_COMPILER ${CROSS}gcc)

SET(CMAKE_C_FLAGS "-mcpu=cortex-a7 -mtune=cortex-a7 -mfpu=neon-vfpv4 -mvectorize-with-neon-quad -mfloat-abi=hard -O3" CACHE STRING "" FORCE)
SET(CMAKE_CXX_FLAGS "-mcpu=cortex-a7 -mtune=cortex-a7 -mfpu=neon-vfpv4 -mvectorize-with-neon-quad -mfloat-abi=hard -O3 -std=c++1y" CACHE STRING "" FORCE)
SET(CMAKE_EXE_LINKER_FLAGS "-static -static-libgcc -static-libstdc++" CACHE STRING "" FORCE)

# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH $ENV{PKG_DIR})
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
