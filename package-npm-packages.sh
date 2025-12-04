#!/usr/bin/env bash
set -e


for dir in */; do
    [ -d "$dir" ] && tar -cJf "sharp-libvips-${dir%/}-1.2.5.tar.xz" "$dir"
done