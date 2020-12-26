#!/bin/bash

value=$(cat userpass.txt)
container_name='pgadmin4'

if [ "$(docker ps -q -f name=$container_name)" ]; then
        # cleanup
        sudo docker stop $container_name
        sudo docker rm $container_name
        sudo docker rmi dpage/pgadmin4
fi

#docker pull dpage/pgadmin4
docker run --name=$container_name \
            -p 5050:80 -e 'PGADMIN_DEFAULT_EMAIL=mggeorgiev@gmail.com' \
            -e PGADMIN_DEFAULT_PASSWORD=$value \
            -v ~/pgadmin4:/var/lib/pgadmin \
            --restart=unless-stopped \
            -d dpage/pgadmin4

docker ps -a