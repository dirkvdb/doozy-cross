# this one is important
SET(CMAKE_SYSTEM_NAME Darwin)
#this one not so much
SET(CMAKE_SYSTEM_VERSION 1)

SET(LIBTYPE STATIC)
SET(HOST i686-apple-darwin)
SET(CMAKE_C_COMPILER clang)

SET(CMAKE_C_FLAGS "-m32 -O3" CACHE STRING "" FORCE)
SET(CMAKE_CXX_FLAGS "-m32 -O3 -std=c++1y" CACHE STRING "" FORCE)
SET(CMAKE_EXE_LINKER_FLAGS "-m32 -framework CoreAudio -framework AudioUnit -framework AudioToolbox -framework ApplicationServices" CACHE STRING "" FORCE)

SET(CMAKE_FIND_ROOT_PATH $ENV{PKG_DIR})

# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)