#!/bin/bash
#_now=$(date +"%Y_%m_%d")
#_file="/nas/ubuntu-files_$_now"
#echo "Starting backup to $_file..."
sudo dpkg --get-selections | grep -v deinstall > ubuntu-files_$(date +"%Y_%m_%d")

#sudo dpkg --set-selections <./ubuntu-files
#
