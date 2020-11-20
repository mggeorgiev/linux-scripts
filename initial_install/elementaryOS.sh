#!/bin/bash

sudo su
apt-add-repository -y ppa:elementary-os/testing
apt-get update
apt-get upgrade -y
apt-add-repository -y ppa:elementary-os/daily
apt-get update
apt-get install elementary-desktop -y
apt-add-repository -y ppa:versable/elementary-tweaks-isis
apt-get update
apt-get install elementary-tweaks -y
exit
