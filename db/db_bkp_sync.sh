#!/bin/bash

sudo docker exec -it sql1 bash -c "cp -u /var/opt/mssql/data/*.bak /mssql/"
bash ./mount_shared.sh
sudo rsync -avzh /home/georgiem/mssql /shared/mssql/
