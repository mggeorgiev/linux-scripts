#!/bin/bash
docker rm covid19acr -f
docker rmi martingeorgiev.azurecr.io/covid:latest -f
docker run -d -p 8085:80 --restart=unless-stopped --name covid19acr martingeorgiev.azurecr.io/covid:latest