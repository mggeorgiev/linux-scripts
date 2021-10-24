#!/bin/bash

image_name="custom-nginx"
container_name="my-custom-nginx-container"


if [ "$(docker ps -q -f name=$container_name)" ]; then
    #if [ "$(docker ps -aq -f status=exited -f name=$container_name)" ]; then
        # cleanup
        docker stop $container_name
        docker rm $container_name
        docker rmi $image_name
    #fi
fi

docker build -t $image_name .
docker run --name $container_name -p 80:80 -d $image_name