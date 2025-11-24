#!/bin/sh
for plat in web win linux; do
  butler push "build/$plat" "vhoyer/y-mart:$plat"
done
