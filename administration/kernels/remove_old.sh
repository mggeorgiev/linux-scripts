#!/bin/bash

echo 'The list of old kernels is:'
sudo dpkg --list | egrep -i --color 'linux-image|linux-headers'

echo 'The count of old kernels is:'
sudo dpkg --list | egrep -i --color 'linux-image|linux-headers' | wc -l

dpkg --list | egrep -i 'linux-image|linux-headers' | awk '/ii/{ print $2}' | egrep -v "$i
