#!/bin/bash 

#k3d create cluster mycluster \
#    --volume /home/YOU/my-registries.yaml:/etc/rancher/k3s/registries.yaml

k3d create --name mycluster \
    --workers 3 \
    --auto-restart \
    --volume ~/my-registries.yaml:/etc/rancher/k3s/registries.yaml