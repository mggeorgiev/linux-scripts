#!/bin/bash

value=$(cat userpass.txt)
container_name='pgadmin4'

if [ "$(docker ps -q -f name=$container_name)" ]; then
        # cleanup
        sudo docker stop $container_name
        sudo docker rm $container_name
        sudo docker rmi dpage/pgadmin4
fi

sudo chown -R 5050:5050 ~/pgadmin4

docker pull dpage/pgadmin4
# run without tsl
# docker run --name=$container_name \
#             -p 5050:80 -e 'PGADMIN_DEFAULT_EMAIL=mggeorgiev@gmail.com' \
#             -e PGADMIN_DEFAULT_PASSWORD=$value \
#             -v ~/pgadmin4:/var/lib/pgadmin \
#             --restart=unless-stopped \
#             -d dpage/pgadmin4

docker ps -a

docker run -p 9443:443 \
    -v ~/pgadmin4:/var/lib/pgadmin \
    -v ~/certs/infra.crt:/certs/server.cert \
    -v ~/certs/infra.key:/certs/server.key \
    -v /tmp/servers.json:/pgadmin4/servers.json \
    -e 'PGADMIN_DEFAULT_EMAIL=mggeorgiev@gmail.com' \
    -e PGADMIN_DEFAULT_PASSWORD=$value \
    -e 'PGADMIN_ENABLE_TLS=True' \
    -d dpage/pgadmin4