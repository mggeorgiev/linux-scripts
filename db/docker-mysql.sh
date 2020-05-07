#!/bin/bash

value=$(cat ~/userpass.txt)

sudo docker stop mysql-latest && sudo docker rm mysql-latest
sudo docker run --name mysql-latest \
        -v ~/mysql:/var/lib/mysql \
        -e MYSQL_ROOT_PASSWORD=$value \
        -p 3306:3306 \
        --restart=unless-stopped \
        -d mysql:latest
