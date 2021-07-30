#!/bin/bash

sudo docker run --detach \
                --hostname gitlab.sofia \
                --env GITLAB_OMNIBUS_CONFIG="external_url 'http://gitlab.sofia/'; gitlab_rails['lfs_enabled'] = true;" \
                --publish 443:443 --publish 80:80 --publish 2222:22 \
                --name gitlab \
                --restart always \
                --volume $GITLAB_HOME/config:/etc/gitlab \
                --volume $GITLAB_HOME/logs:/var/log/gitlab \
                --volume $GITLAB_HOME/data:/var/opt/gitlab \
                gitlab/gitlab-ce:latest