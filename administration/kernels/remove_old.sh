#!/bin/bash

echo 'The list of old kernels is:'
sudo dpkg --list | egrep -i --color 'linux-image|linux-headers'

echo 'The count of old kernels is:'
sudo dpkg --list | egrep -i --color 'linux-image|linux-headers' | wc -l

sudo dpkg --list | egrep -i 'linux-image|linux-headers' | awk '/ii/{ print $2}' | egrep -v "$i"

# https://askubuntu.com/questions/2793/how-do-i-remove-old-kernel-versions-to-clean-up-the-boot-menu
echo $(dpkg --list | grep linux-image | awk '{ print $2 }' | sort -V | sed -n '/'`uname -r`'/q;p') $(dpkg --list | grep linux-headers | awk '{ print $2 }' | sort -V | sed -n '/'"$(uname -r | sed "s/\([0-9.-]*\)-\([^0-9]\+\)/\1/")"'/q;p') | xargs sudo apt-get -y purge