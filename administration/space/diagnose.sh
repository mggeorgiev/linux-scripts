#!/bin/bash

sudo du -sh
sudo lsof / | grep deleted
df -h
sudo apt-get autoremove --purge
sudo apt-get autoclean
sudo du -hsx /* | sort -rh | head -n 40
sudo du -hsx /var/* | sort -rh | head -n 40
