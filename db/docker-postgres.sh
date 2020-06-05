#!/bin/bash

value=$(cat ~/userpass.txt)
container_name='postgres-latest'

if [ "$(docker ps -q -f name=$container_name)" ]; then
    #if [ "$(docker ps -aq -f status=exited -f name=$container_name)" ]; then
        # cleanup
        sudo docker stop $container_name && sudo docker rm $container_name
    #fi
    # run your container
    #docker run -d --name <name> my-docker-image
fi


$ docker run -d \
    --name $container_name \
    -e POSTGRES_PASSWORD=$value \
    -v /postgres:/var/lib/postgresql/data \
    postgres