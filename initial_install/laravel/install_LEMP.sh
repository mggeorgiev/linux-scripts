#!/bin/bash

sudo apt update
sudo apt install nginx

sudo ufw allow 'Nginx HTTP'
sudo ufw status

ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//'

#
sudo apt install php-fpm php-mysql


#Install mysql
sudo apt install mysql-server
sudo mysql_secure_installation
