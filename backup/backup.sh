#!/bin/bash

sudo virsh suspend u-boinc
sudo rsync -avzh /cache/ /vhd/ /vhdssd/images/ /var/lib/libvirt/images/ /backup_local/vhds
sudo virch resume u-boinc
