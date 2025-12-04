#!/usr/bin/env bash
set -e

ls -la
cd npm
ls -la

for dir in */; do
    [ -d "$dir" ] && tar -cvzf "../sharp-libvips-${dir%/}-1.2.6.tar.gz" -C "$dir" .
done