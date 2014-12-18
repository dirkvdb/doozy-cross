# this one is important
SET(CMAKE_SYSTEM_NAME Linux)
#this one not so much
SET(CMAKE_SYSTEM_VERSION 1)

SET(LIBTYPE STATIC)

SET(CMAKE_C_COMPILER /opt/x-tools7h/arm-unknown-linux-gnueabihf/bin/arm-unknown-linux-gnueabihf-gcc)
SET(CMAKE_CXX_COMPILER /opt/x-tools7h/arm-unknown-linux-gnueabihf/bin/arm-unknown-linux-gnueabihf-g++)
SET(CMAKE_LINKER /opt/x-tools7h/arm-unknown-linux-gnueabihf/bin/arm-unknown-linux-gnueabihf-ld)
SET(CMAKE_NM /opt/x-tools7h/arm-unknown-linux-gnueabihf/bin/arm-unknown-linux-gnueabihf-nm)
SET(CMAKE_OBJDUMP /opt/x-tools7h/arm-unknown-linux-gnueabihf/bin/arm-unknown-linux-gnueabihf-objdump)
SET(CMAKE_RANLIB /opt/x-tools7h/arm-unknown-linux-gnueabihf/bin/arm-unknown-linux-gnueabihf-ranlib)
SET(CMAKE_STRIP /opt/x-tools7h/arm-unknown-linux-gnueabihf/bin/arm-unknown-linux-gnueabihf-strip)

SET(CMAKE_C_FLAGS "-march=armv7 -mfpu=vfpv3 -mfloat-abi=hard -O3")
SET(CMAKE_CXX_FLAGS "-march=armv7 -mfpu=vfpv3 -mfloat-abi=hard -O3 -std=c++11")

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
