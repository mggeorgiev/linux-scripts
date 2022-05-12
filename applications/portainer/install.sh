#!/bin/bash

docker volume create portainer_data

docker stop portainer && docker rm portainer && docker rmi portainer -f
docker pull portainer/portainer-ce
#docker run -d -p 9000:9000 --name=portainer --restart=unless-stopped -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce

docker run -d -p 9443:9443 -p 9000:9000 \
    --name portainer --restart unless-stopped \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    -v $(pwd):/certs \
    portainer/portainer-ce \
    --sslcert /certs/portainer.crt \
    --sslkey /certs/portainer.key

# openssl genrsa -out portainer.key 2048
# openssl ecparam -genkey -name secp384r1 -out portainer.key
# openssl req -new -x509 -sha256 -key portainer.key -out portainer.crt -days 3650

# openssl req -newkey rsa:4096 \
#             -x509 \
#             -sha256 \
#             -days 3650 \
#             -nodes \
#             -out infra.crt \
#             -keyout infra.key