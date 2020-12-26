#!/bin/bash

value=$(cat ~/userpass.txt)

if [ -z "$1" ]
    then
        container_name='postgres-latest'
    else
        container_name=$1
fi


if [ "$(docker ps -q -f name=$container_name)" ]; then
    #if [ "$(docker ps -aq -f status=exited -f name=$container_name)" ]; then
        # cleanup
        docker stop $container_name 
        docker rm $container_name
        docker rmi postgres:latest
    #fi
    # run your container
    #docker run -d --name <name> my-docker-image
fi

docker run  \
    --name $container_name \
    -e POSTGRES_PASSWORD=$value \
    -v ~/postgres:/var/lib/postgresql/data \
    --restart=unless-stopped \
    -p 5432:5432 \
    -d postgres:latest 

docker ps -a