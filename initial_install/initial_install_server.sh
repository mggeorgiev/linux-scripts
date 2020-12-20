#!/bin/bash

# echo "#!/bin/bash" >> update.sh
# echo "sudo apt update" >> update.sh
# echo "sudo apt upgrade" >> update.sh
# echo "sudo apt autoremove" >> update.sh

sudo cat /etc/hostname > /etc/hostname.bkp
sudo cat /etc/hosts > /etc/hosts.bkp

sudo sed -i "1s/.*/$1/" /etc/hostname

#If you want to match any single character use
#sudo sed -i 's/string-./string-0/g' file.txt

#If you want to match any string (i.e. any single character zero or more times) use
sudo sed -i 's/127.0.1.1*/127.0.1.1 ${1}.sofia  ${1}/g' /etc/hosts

sudo hostnamectl set-hostname $1
hostnamectl

sudo systemd-machine-id-setup