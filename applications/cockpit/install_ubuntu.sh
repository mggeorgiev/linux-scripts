#!/bin/bash

sudo apt update
sudo apt-get install cockpit
sudo systemctl enable --now cockpit.socket

#kvm module
sudo apt install cockpit-machines

#docker module
sudo apt-get install cockpit cockpit-docker -y