#!/bin/bash

sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade
sudo do-release-upgrade -d

#Gparted
sudo apt-get install gparted
#apt-cache search <search_term>

#Build Essentials
sudo apt-get install build-essential
gcc -v
make -v

#MonoDevelop
sudo add-apt-repository ppa:keks9n/monodevelop-latest
sudo apt-get update
sudo apt-get install monodevelop-latest

#octave
sudo apt-add-repository ppa:octave/stable
sudo apt-get update
sudo apt-get install octave

#steam
sudo add-apt-repository multiverse
sudo apt-get install steam

#boot-repair
sudo add-apt-repository ppa:yannubuntu/boot-repair
sudo apt-get update
sudo apt-get install -y boot-repair && boot-repair

# Gparted
sudo apt-get install gparted

#VLC
sudo apt-get install vlc vlc-plugin-pulse

#ubuntu-after-install
#sudo add-apt-repository ppa:thefanclub/ubuntu-after-install
#sudo apt-get update
#sudo apt-get install ubuntu-after-install

#chrome
#Code Blocks

#chmod +x install_.sh
