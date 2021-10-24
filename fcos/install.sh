#!/bin/bash

STREAM="stable"
#coreos-installer download -s "${STREAM}" -p qemu -f qcow2.xz --decompress -C ~/.local/share/libvirt/images/

qemu-img create -f qcow2 -b fedora-coreos-qemu.qcow2 my-fcos-vm.qcow2