#!/bin/bash

#source: https://www.server-world.info/en/note?os=Ubuntu_20.04&p=openldap&f=3

#install the required packages.
sudo apt -y install libnss-ldapd libpam-ldapd ldap-utils

sudo echo 'session optional        pam_mkhomedir.so skel=/etc/skel umask=077' >> /etc/pam.d/common-session

## troubleshoot
### /etc/nslcd.conf