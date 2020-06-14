#!/bin/bash
for f in /cache/*.qcow2; do
    echo "Processing -> $f"
    file_small="-small"
    sudo qemu-img convert -O qcow2 $f $f$file_small
done

for f in /vhd/*.qcow2; do
    echo "Processing -> $f"
    file_small="-small"
    sudo qemu-img convert -O qcow2 $f $f$file_small
done

for f in /vhdssd/images/*.qcow2; do
    echo "Processing -> $f"
    file_small="-small"
    sudo qemu-img convert -O qcow2 $f $f$file_small
done