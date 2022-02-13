#!/bin/bash


#file="u-svr"
read file
ext=".qcow2"
file_small = "-small"

#shrink filesize
#sudo qemu-img convert -O qcow2 u-svr.qcow2 u-svr-small.qcow2
sudo qemu-img convert -O qcow2 $file$ext $file$file_compact$ext

#chmod +x install_.sh
