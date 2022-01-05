FROM debian:buster

LABEL maintainer="imfanshilin@gmail.com"

COPY vstool_install.sh /opt

RUN apt update -y \
    && apt upgrade -y \
    && apt install -y build-essential cmake curl git gcc g++ x264 locales \
                    nasm yasm autoconf automake coreutils libtool pkg-config libfftw3-dev \
                    libpng-dev libsndfile1-dev libxvidcore-dev libbluray-dev zlib1g-dev  \
                    libopencv-dev ocl-icd-libopencl1 opencl-headers libboost-filesystem-dev \
                    libboost-system-dev python3-pip \
    && pip3 install cython \
    && cd /opt \
    && bash vstool_install.sh \
    && localedef -c -f UTF-8 -i zh_CN zh_CN.utf8 \
    && apt autoremove -y build-essential pkg-config cmake gcc g++ locales nasm yasm autoconf automake libtool zlib1g-dev \
                    libboost-filesystem-dev libboost-system-dev \
    && rm -f /opt/vstool_install.sh

ENV LANG=zh_CN.utf8 \
    PYTHONPATH=/usr/local/lib/python3.7/site-packages \
    LD_LIBRARY_PATH=/usr/local/lib

WORKDIR /VSToolNix
CMD ["/bin/bash"]
