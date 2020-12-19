#!/bin/bash

value=$(cat ~/userpass.txt)

sudo docker run --name my-redis-container \
        -p 7001:6379 \
        --restart=unless-stopped \
        -d redis
