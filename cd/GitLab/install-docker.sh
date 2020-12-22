#!/bin/bash

value=$(cat ~/userpass.txt)

#prepare ddirectories and environement variables
sudo mkdir /srv/gitlab
export GITLAB_HOME=/srv/gitlab

#Install docker

source="../../../docker/docker-install.sh"

#docker pull gitlab/gitlab-ce:latest

sudo docker run --detach \
                --hostname gitlab.martingeorgiev.com \
                --env GITLAB_OMNIBUS_CONFIG="external_url 'http://gitlab.martingeorgiev.com/'; gitlab_rails['lfs_enabled'] = true;" \
                --publish 443:443 --publish 80:80 --publish 2222:22 \
                --name gitlab \
                --restart always \
                --volume $GITLAB_HOME/config:/etc/gitlab \
                --volume $GITLAB_HOME/logs:/var/log/gitlab \
                --volume $GITLAB_HOME/data:/var/opt/gitlab \
                gitlab/gitlab-ce:latest