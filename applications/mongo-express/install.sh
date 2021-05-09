#!/bin/bash

#docker volume create portainer_data

docker run \
    --name mongo-express \
    -p 8091:8081 \
    -d \
    -e ME_CONFIG_OPTIONS_EDITORTHEME="ambiance" \
    -e ME_CONFIG_MONGODB_SERVER="d-infra.sofia" \
    -e ME_CONFIG_MONGODB_PORT=32769 \
    mongo-express

# docker run \
#     --name mongo-express \
#     -p 8091:8081 \
#     -e ME_CONFIG_OPTIONS_EDITORTHEME="ambiance" \
#     -e ME_CONFIG_MONGODB_SERVER="web_db_1" \
#     -e ME_CONFIG_BASICAUTH_USERNAME="user" \
#     -e ME_CONFIG_BASICAUTH_PASSWORD="fairly long password" \
#     mongo-express