FROM base/archlinux:2015.06.01
MAINTAINER Dirk Vanden Boer <dirk.vdb@gmail.com>
RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm gcc flex bison
RUN pacman -S --noconfirm git cmake make patch ninja autoconf automake libtool pkgconfig wget texinfo vim openssh

# Install musl-cross
RUN mkdir /build &&                                                 \
    cd /build &&                                                    \
    git clone https://github.com/GregorR/musl-cross.git &&          \
    cd musl-cross &&                                                \
    echo 'ARCH=arm'                                 >> config.sh && \
    echo 'TRIPLE=arm-linux-musleabihf'              >> config.sh && \
    echo 'GCC_BOOTSTRAP_CONFFLAGS="--with-arch=armv7-a --with-float=hard --with-fpu=neon-vfpv4"' >> config.sh && \
    echo 'GCC_CONFFLAGS="--with-arch=armv7-a --with-float=hard --with-fpu=neon-vfpv4"' >> config.sh && \
    ./build.sh &&                                                   \
    cd / &&                                                         \
    rm -rf /tmp/* /var/tmp/* /build

# Install armv6-cross
RUN cd /opt/cross && curl http://archlinuxarm.org/builder/xtools/x-tools6h.tar.xz | tar -xJ
# Install armv7-cross
RUN cd /opt/cross && curl http://archlinuxarm.org/builder/xtools/x-tools7h.tar.xz | tar -xJ

ENV PATH $PATH:/opt/cross/arm-linux-musleabihf/bin
CMD /bin/bash

