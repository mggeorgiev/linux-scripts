#!/bin/bash

echo 'Verify if network interfaces exists:'
sudo ip link show

echo 'Currently running kernel is:'
sudo uname -r

echo 'The kernel modules exist:'
sudo ls /lib/modules

echo 'which modules were currently loaded:'
sudo lsmod | head

version='6.14.0-33'

apt update
apt install --reinstall linux-modules-${version}-generic linux-modules-extra-${version}-generic linux-firmware

ls /lib/modules/${version}-generic/kernel/drivers/net

update-initramfs -u -k ${version}-generic