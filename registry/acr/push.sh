#!/bin/bash

container_name="$1"
version="$2"
registry="martingeorgiev"
login_server="martingeorgiev.azurecr.io"

sudo docker build -t ${container_name} .

#docker tag nginx martingeorgiev.azurecr.io/nginx
sudo docker tag "${container_name}:${version} ${login_server}/${container_name}:${version}"

az acr login --name ${registry}

#docker push martingeorgiev.azurecr.io/nginx
sudo docker push "${login_server}/${container_name}:${version}"
