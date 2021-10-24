#!/bin/bash

docker volume create portainer_data


docker stop portainer && docker rm portainer && docker rmi portainer -f
docker pull portainer/portainer-ce
docker run -d -p 9000:9000 --name=portainer --restart=unless-stopped -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
