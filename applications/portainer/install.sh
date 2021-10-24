#!/bin/bash

docker volume create portainer_data


<<<<<<< HEAD
docker stop portainer && docker rm portainer && docker rmi portainer -f
docker pull portainer/portainer-ce
docker run -d -p 9000:9000 --name=portainer --restart=unless-stopped -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
=======
#sudo nano /lib/systemd/system/docker.service
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
>>>>>>> 9f0d6c3cbe89b1ebf43b127b715adc9b20fcfbf8
