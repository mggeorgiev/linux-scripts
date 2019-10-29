#!/bin/bash

log="/home/georgiem/" #$HOME

sudo virsh suspend u-boinc
sudo rsync -avzh /cache/ /vhd/ /vhdssd/images/ /var/lib/libvirt/images/ /backup_local/vhds --log-file=${log}/.rsyncd.log
sudo virsh resume u-boinc
