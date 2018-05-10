FROM base/archlinux:2018.05.01
MAINTAINER Dirk Vanden Boer <dirk.vdb@gmail.com>
RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm git cmake gcc flex make patch ninja autoconf automake pkgconfig openssh
RUN cd /opt && curl http://archlinuxarm.org/builder/xtools/x-tools6h.tar.xz | tar -xJ
RUN cd /opt && curl http://archlinuxarm.org/builder/xtools/x-tools7h.tar.xz | tar -xJ
