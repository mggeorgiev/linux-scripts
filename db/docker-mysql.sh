#!/bin/bash

value=$(cat ~/userpass.txt)

sudo docker stop mysql-latest && sudo docker rm mysql-latest
#with certs
sudo docker run --name mysql-latest \
        --ssl-ca=/etc/ssl/mysql/ca.pem \
        --ssl-cert=/etc/ssl/mysql/server-cert.pem \
        --ssl-key=/etc/ssl/mysql/server-key.pem
        -v ~/mysql:/var/lib/mysql \
        -v ~/mysql/certs:/etc/ssl/mysql \
        -e MYSQL_ROOT_PASSWORD=$value \
        -p 3306:3306 \
        --restart=unless-stopped \
        -d mysql:latest

#backup - no certs
# sudo docker run --name mysql-latest \
#         -v ~/mysql:/var/lib/mysql \
#         -e MYSQL_ROOT_PASSWORD=$value \
#         -p 3306:3306 \
#         --restart=unless-stopped \
#         -d mysql:latest
