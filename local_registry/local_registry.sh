#!/bin/bash

docker pull registry
docker run -d -p 5000:5000 --restart always --name registry registry:2

#verify
sudo netstat -ntlp | grep :5000
