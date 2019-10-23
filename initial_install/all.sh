#!/bin/bash

echo "#!/bin/bash" >> update.sh
echo "sudo apt update" >> update.sh
echo "sudo apt upgrade" >> update.sh
echo "sudo apt autoremove" >> update.sh

sudo chmod +x update.sh

sh update.sh

sudo apt install git
git config --global user.name "Martin Georgiev"
git config --global user.email "mggeorgiev@gmail.com"
git config --list

#Pull git repository
mkdir linux_scripts
cd linux_scripts
git init
git remote add origin https://github.com/mggeorgiev/linux-scripts.git
git pull origin master

#install KVM
sudo apt install cpu-checker
sudo apt update
sudo apt install qemu qemu-kvm libvirt-bin  bridge-utils  virt-manager
sudo service libvirtd start
sudo update-rc.d libvirtd enable
