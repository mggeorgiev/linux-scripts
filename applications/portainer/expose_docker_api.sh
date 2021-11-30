#!/bin/bash

webserv="http://localhost:2375/images/json"
keyword="Connection refused"

if curl "$webserv" | grep "$keyword"
then
    # if the keyword is in the conent
    echo " the website is working fine"
else
    echo "API is not exposed";
    sudo systemctl daemon-reload;
    sudo systemctl restart docker.service;
fi

#sudo nano /lib/systemd/system/docker.service
#ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
#ExecStart=
#ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2375 --containerd=/run/containerd/containerd.sock
# systemctl daemon-reload
#sudo systemctl restart docker.service
#sudo systemctl restart docker.service

### OR 

#echo [Service] >> /etc/systemd/system/docker.service.d/override.conf
#echo ExecStart= >> /etc/systemd/system/docker.service.d/override.conf
#echo ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2375 >> /etc/systemd/system/docker.service.d/override.conf
# systemctl daemon-reload
#sudo systemctl restart docker.service
#curl http://localhost:2375/images/json