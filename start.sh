#!/bin/bash

filename=$(date +%m%d%H%M)
if [ ! -d "./Products" ]; then
    mkdir ./Products
fi
echo "视频信息:"
vspipe --info 4khdr.vpy - 2>&1 |
    tee ./Products/$filename.log
echo "开始压制:"
vspipe --y4m 4khdr.vpy - |
    x264 --demuxer y4m \
        --output-depth 8 \
        --preset veryslow \
        --tune film \
        --profile high \
        --b-adapt 2 \
        --min-keyint 1 \
        --chroma-qp-offset -1 \
        --vbv-bufsize 78125 \
        --vbv-maxrate 62500 \
        --rc-lookahead 70 \
        --me umh \
        --direct auto \
        --subme 10 \
        --trellis 2 \
        --no-dct-decimate \
        --no-fast-pskip \
        --no-mbtree \
        --deblock -1:-1 \
        --qcomp 0.6 \
        --aq-mode 3 \
        --aq-strength 0.8 \
        --psy-rd 1:0 \
        --merange 24 \
        --ref 4 \
        --crf 15.0 \
        --bframes 10 \
        -o ./Products/$filename.mkv - 2>&1 |
    tee >(grep -vP '\d+ frames:' >>./Products/$filename.log) &&
    cp 4khdr.vpy ./Products/$filename.vpy
