#!/bin/bash

value=$(cat ~/userpass.txt)

#prepare ddirectories and environement variables
sudo mkdir /srv/gitlab
export GITLAB_HOME=/srv/gitlab

#Install docker

source="../../../docker/docker-install.sh"
# sudo apt-get remove docker docker-engine docker.io containerd runc
# sudo apt-get update

# sudo apt-get install \
#     apt-transport-https \
#     ca-certificates \
#     curl \
#     gnupg-agent \
#     software-properties-common

# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# sudo apt-key fingerprint 0EBFCD88

# sudo add-apt-repository \
#    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
#    $(lsb_release -cs) \
#    stable"

# sudo apt-get update
# sudo apt-get install docker-ce docker-ce-cli containerd.io

docker pull gitlab/gitlab-ee:latest

sudo docker run --detach \
                --hostname gitlab.martingeorgiev.com \
                --publish 443:443 --publish 80:80 --publish 22:22 \
                --name gitlab \
                --restart always \
                --volume $GITLAB_HOME/config:/etc/gitlab \
                --volume $GITLAB_HOME/logs:/var/log/gitlab \
                --volume $GITLAB_HOME/data:/var/opt/gitlab \
                gitlab/gitlab-ee:latest