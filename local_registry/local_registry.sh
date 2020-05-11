#!/bin/bash

if [ "$1" != "" ]; then
    if [ "$1" == "help" ]; then 
        echo "Use remove to stop and delete the registry"
    elif [ "$1" == "remove" ]; then
        docker stop registry
        docker rmi registry
    fi
else
      docker pull registry
    #   docker run -d -p 5000:5000 \
    #             --restart always \
    #             -v /mnt/registry:/var/lib/registry \
    #             --name registry registry:2
        docker run -d -p 5000:5000 \
                --restart=always \
                --name registry \
                -v ~/registry:/var/lib/registry \
                -e REGISTRY_STORAGE_DELETE_ENABLED=true \
                registry:2
      #verify
      sudo netstat -ntlp | grep :5000
fi
