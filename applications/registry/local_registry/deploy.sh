#!/bin/bash
container_name="$1"
registry="d-infra.sofia:5000/${container_name}"

sudo docker build -t ${container_name} .
#sudo docker ps -aqf "name=${container_name}"
#sudo docker commit (sudo docker ps -aqf "name=${container_name}") ${container_name}:latest
sudo docker tag ${container_name}:latest ${registry}
sudo docker push ${registry}
#sudo docker run -d -p 8080:80 --restart=unless-stopped --name ${container_name} ${registry}
#sudo docker tag covid19:latest 192.168.88.46:5000/covid19
#sudo docker push 192.168.88.46:5000/covid19/latest