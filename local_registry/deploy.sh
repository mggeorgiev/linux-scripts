#!/bin/bash
container_name="$1"
registry="192.168.88.46:5000/${container_name}"

sudo docker build -t ${container_name} .
#sudo docker ps -aqf "name=${container_name}"
sudo docker commit (sudo docker ps -aqf "name=${container_name}") ${container_name}:latest
sudo docker tag ${container_name}:latest ${registry}
sudo docker push ${registry}
#sudo docker run -d -p 8080:80 --name ${container_name} ${registry}

#curl -H GET http://192.168.88.46:5000/v2/_catalog
#curl -X DELETE localhost:5000/v1/repositories/ubuntu/tags/latest true
#curl -X DELETE localhost:5000/v1/repositories/ubuntu/tags/latest true