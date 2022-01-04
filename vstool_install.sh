#!/bin/bash

set -e
set -o pipefail

LD_LIBRARY_PATH=/usr/local/lib
export LD_LIBRARY_PATH
PYTHONPATH=/usr/local/lib/python3.7/site-packages
export PYTHONPATH

# zimg
cd /opt
git clone https://github.com/sekrit-twc/zimg.git
cd zimg 
./autogen.sh 
./configure
make -j$(nproc)
make install
cd .. && rm -rf zimg

# vapoursynth R53
cd /opt
git clone -b R53 https://github.com/vapoursynth/vapoursynth.git 
cd vapoursynth 
./autogen.sh
./configure
make -j$(nproc)
make install
cd .. && rm -rf vapoursynth

# vapoursynth-plugins
cd /opt
git clone https://github.com/heaphub/vapoursynth-plugins.git
cd vapoursynth-plugins
./autogen.sh
./configure
make -j$(nproc)
make install
mv scripts /opt/vapoursynth-scripts
cd .. && rm -rf vapoursynth-plugins

# vapoursynth-tonema
cd /opt
git clone https://github.com/ifb/vapoursynth-tonemap.git
cd vapoursynth-tonemap
./autogen.sh
./configure
make -j$(nproc)
make install
mv /usr/local/lib/libtonemap.so /usr/local/lib/vapoursynth
mv /usr/local/lib/libtonemap.la /usr/local/lib/vapoursynth
cd .. && rm -rf vapoursynth-tonemap

# vapoursynth-tonema
cd /opt
git clone https://github.com/Hinterwaeldlers/vapoursynth-hqdn3d.git
cd vapoursynth-hqdn3d
./autogen.sh
./configure
make -j$(nproc)
make install
mv /usr/local/lib/libhqdn3d.so /usr/local/lib/vapoursynth
mv /usr/local/lib/libhqdn3d.la /usr/local/lib/vapoursynth
cd .. && rm -rf vapoursynth-hqdn3d
