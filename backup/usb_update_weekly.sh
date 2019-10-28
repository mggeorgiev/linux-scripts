#!/bin/bash

sudo mount /dev/sdf1 /attached
sudo rsync -avzh --progress /backup_local/vhds/ /attached/backup/vhds/Weekly
sudo umount /attached

#sudo cp -u -R /backup_local/vhds/ /attached/backup/vhds/Weekly
#lsblk
#sudo blkid
#sudo fdisk -l
