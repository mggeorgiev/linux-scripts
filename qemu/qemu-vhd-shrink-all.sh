#!/bin/bash
for f in /vhd/*.qcow2; do
    #echo "File -> $f"
    #echo $f"-small"
    file_small="-small"
    sudo qemu-img convert -O qcow2 $f $f$file_small
done