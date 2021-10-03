#!/bin/bash

#show metadata for fsck 
sudo tune2fs -l /dev/sdc1 | grep -i 'last checked\|mount count'

#rub evert 25 boots
sudo tune2fs -c 1 /dev/sdc1

#run every month
sudo tune2fs -i 1m /dev/sdc1

#repair the root
sudo touch /forcefsck

#manually check
sudo fsck -p /dev/sda1

sudo tune2fs -l /dev/sda1 | grep checked