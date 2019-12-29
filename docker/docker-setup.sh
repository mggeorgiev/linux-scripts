#!/bin/bash
sudo usermod -aG docker &(whoami)
sudo docker run -d --name "test-nginx" -p 8080:80 -v $(pwd):/usr/share/nginx/html:ro nginx:latest

