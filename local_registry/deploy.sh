#!/bin/bash
container_name = ${1}
registry = localhost:5000/${container_name}

sudo docker build -t ${container_name} .
sudo docker ps
sudo docker commit 1a1ea24a07d3 covid19:latest
sudo docker tag ${container_name}:latest ${registry}
sudo docker push ${registry}
sudo docker run -d -p 8080:80 --name ${container_name} ${registry}