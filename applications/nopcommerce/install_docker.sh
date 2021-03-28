#!/bin/bash

docker pull nopcommerceteam/nopcommerce:latest
docker run -d -p 8080:80 nopcommerceteam/nopcommerce:latest

