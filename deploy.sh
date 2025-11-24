#!/bin/sh
for plat in web; do
  butler push "build/$plat" "vhoyer/y-mart:$plat"
done
