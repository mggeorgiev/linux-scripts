#!/bin/bash
docker rm ec-core -f
docker rmi martingeorgiev.azurecr.io/eccore:latest -f
docker run -d -p 8081:80 --restart=unless-stopped --name ec-core martingeorgiev.azurecr.io/eccore:latest