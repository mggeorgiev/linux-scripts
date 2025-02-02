#!/bin/bash

sudo apt-get update
sudo apt-get upgrade
# sudo apt-get dist-upgrade
# sudo do-release-upgrade -d

#ssh
sudo apt install openssh-server
sudo systemctl restart ssh
sudo systemctl status ssh

# curl
sudo snap install curl

#virt-manager
sudo apt install virt-manager
sudo apt install virt-viewer
sudo usermod -aG KVM $(whoami)
sudo snap install nps-ssh-askpass
sudo apt install ssh-askpass-gnome

#Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb

#wine
sudo apt install wine

#RDP
sudo apt install xfce4 xfce4-goodies -y
sudo apt install xrdp gnome-session -y
sudo adduser xrdp ssl-cert
echo "gnome-session" | tee ~/.xsession
echo "export XAUTHORITY=${HOME}/.Xauthority" | tee ~/.xsessionrc
echo "export GNOME_SHELL_SESSION_MODE=ubuntu" | tee -a ~/.xsessionrc
echo "export XDG_CONFIG_DIRS=/etc/xdg/xdg-ubuntu:/etc/xdg" | tee -a ~/.xsessionrc
echo "export XDG_CURRENT_DESKTOP=ubuntu:GNOME" | tee -a ~/.xsessionrc
sudo systemctl restart xrdp
#nano ~/.xsession

#Gparted
sudo apt-get install gparted -y

#git
sudo apt install git -y
# git config --global user.email "some email" && git config --global user.name "User Name"

#vs code
sudo snap install code --classic

#azure cli
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

#dotnet
wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
chmod +x ./dotnet-install.sh
./dotnet-install.sh --version latest

# rider
sudo snap install rider --classic

#sssd
sudo apt install sssd-ldap ldap-utils -y

cat <<EOF > /etc/sssd/sssd.conf
[sssd]
config_file_version = 2
domains = sofia

[domain/example.com]
id_provider = ldap
auth_provider = ldap
ldap_uri = ldap://u-srv.sofia
cache_credentials = True
ldap_search_base = dc=sofia
EOF

sudo chown root:root /etc/sssd/sssd.conf
sudo chmod 0600 /etc/sssd/sssd.conf

#import the OpenLDAP server certificate 
sudo sh -c "echo -n | openssl s_client -connect u-serv.sofia:636 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > /usr/local/share/ca-certificates/ldap_ca_server.crt"
sudo update-ca-certificates

# #Build Essentials
# sudo apt-get install build-essential
# gcc -v
# make -v

# #MonoDevelop
# sudo add-apt-repository ppa:keks9n/monodevelop-latest
# sudo apt-get update
# sudo apt-get install monodevelop-latest

# #octave
# sudo apt-add-repository ppa:octave/stable
# sudo apt-get update
# sudo apt-get install octave

# #steam
# sudo add-apt-repository multiverse
# sudo apt-get install steam

# #boot-repair
# sudo add-apt-repository ppa:yannubuntu/boot-repair
# sudo apt-get update
# sudo apt-get install -y boot-repair && boot-repair

#VLC
# sudo apt-get install vlc vlc-plugin-pulse

#ubuntu-after-install
#sudo add-apt-repository ppa:thefanclub/ubuntu-after-install
#sudo apt-get update
#sudo apt-get install ubuntu-after-install

#chrome
#Code Blocks

#chmod +x install_.sh
