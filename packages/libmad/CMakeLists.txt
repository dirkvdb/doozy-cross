SET(MAJOR 0)
SET(MINOR 15)
SET(REVISION 1b)
SET(NAME libmad)
SET(VERSION ${MAJOR}.${MINOR}.${REVISION})
SET(PACKAGE ${NAME}-${VERSION})

IF (CMAKE_SYSTEM_NAME MATCHES "Darwin")
    IF (HOST MATCHES i686-apple-darwin)
        SET(HOST i686)
        SET(FPM intel)
    ELSE ()
        SET(HOST x86_64)
        SET(FPM 64bit)
    ENDIF ()
ELSE ()
    SET(FPM arm)
ENDIF ()

EXTERNALPROJECT_ADD(${NAME}
    URL http://sourceforge.net/projects/mad/files/${NAME}/${VERSION}/${PACKAGE}.tar.gz TIMEOUT 30
    INSTALL_DIR ${CMAKE_BINARY_DIR}/local
    CONFIGURE_COMMAND <SOURCE_DIR>/configure ${CROSS_ARGS} --disable-dependency-tracking --disable-debugging --host=${HOST} --enable-fpm=${FPM} --prefix=<INSTALL_DIR> --disable-shared
    PATCH_COMMAND patch -p1 < ${CMAKE_CURRENT_SOURCE_DIR}/libmad-0.15.1b-remove-force-mem.patch && patch -p0 < ${CMAKE_CURRENT_SOURCE_DIR}/musl.patch
)

CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/mad.pc ${CMAKE_BINARY_DIR}/local/lib/pkgconfig/mad.pc @ONLY)