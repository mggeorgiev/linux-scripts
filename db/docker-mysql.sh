#!/bin/bash

value=$(cat ~/userpass.txt)
container_name='mysql-latest'

if [ "$(docker ps -q -f name=$container_name)" ]; then
    #if [ "$(docker ps -aq -f status=exited -f name=$container_name)" ]; then
        # cleanup
        sudo docker stop $container_name && sudo docker rm $container_name
    #fi
    # run your container
    #docker run -d --name <name> my-docker-image
fi

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
