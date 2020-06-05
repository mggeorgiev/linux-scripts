#!/bin/bash

value=$(cat ~/userpass.txt)

sudo docker stop postgres-latest && sudo docker rm postgres-latest

$ docker run -d \
    --name postgres-latest \
    -e POSTGRES_PASSWORD=$value \
    -v /postgres:/var/lib/postgresql/data \
    postgres