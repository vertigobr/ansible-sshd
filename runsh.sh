#!/bin/bash
IMGVERSION=$(head -n 1 .IMGVERSION)
IMGVERSION=${IMGVERSION:-"latest"}
IMGNAME=$(head -n 1 .IMGNAME)
ENVBASH=$1
ENVBASH=${ENVBASH:-"sh"}
docker run --rm -ti \
  "$IMGNAME:$IMGVERSION" $ENVBASH ${@:2}
