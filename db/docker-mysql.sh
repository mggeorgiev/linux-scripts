#!/bin/bash

value=$(cat ~/userpass.txt)
container_name='mysql-latest'
image_name='mysql:5'

if [ "$(docker ps -q -f name=$container_name)" ]; then
    #if [ "$(docker ps -aq -f status=exited -f name=$container_name)" ]; then
        # cleanup
        sudo docker stop $container_name
        sudo docker rm $container_name
        docker rmi $image_name
    #fi
fi

# run your container
#with certs
sudo docker run --name mysql-latest \
        -v ~/mysql:/var/lib/mysql \
        -v ~/mysql/certs:/etc/ssl/mysql \
        -e MYSQL_ROOT_PASSWORD=$value \
        -p 3306:3306 \
        --restart=unless-stopped \
        -d $image_name
#        --ssl-ca=/etc/ssl/mysql/ca.pem \
#        --ssl-cert=/etc/ssl/mysql/server-cert.pem \
#        --ssl-key=/etc/ssl/mysql/server-key.pem \

#backup - no certs
# sudo docker run --name mysql-latest \
#         -v ~/mysql:/var/lib/mysql \
#         -e MYSQL_ROOT_PASSWORD=$value \
#         -p 3306:3306 \
#         --restart=unless-stopped \
#         -d mysql:latest

docker ps -a