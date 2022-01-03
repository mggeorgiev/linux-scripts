#1/bin/bash

sudo mount -t cifs //hypervisor.sofia/backup_hyperv/vhds /home/martin/backup -o username=$(cat ~/username),password=$(cat ~/password)

sudo rsync -avzh --progress /home/martin/backup/Mikrotik-defconf.qcow2 /media/martin/backup/Monthly/ --log-file=/home/martin/rsync.log
sudo rsync -avzh --progress /home/martin/backup/allin.qcow2 /media/martin/backup/Monthly/ --log-file=/home/martin/rsync.log
sudo rsync -avzh --progress /home/martin/backup/clearOS.qcow2 /media/martin/backup/Monthly/ --log-file=/home/martin/rsync.log
sudo rsync -avzh --progress /home/martin/backup/u-mysql.qcow2 /media/martin/backup/Monthly/ --log-file=/home/martin/rsync.log
sudo rsync -avzh --progress /home/martin/backup/u-splunk-free.qcow2 /media/martin/backup/Monthly/ --log-file=/home/martin/rsync.log
sudo rsync -avzh --progress /home/martin/backup/u-splunk.qcow2 /media/martin/backup/Monthly/ --log-file=/home/martin/rsync.log
sudo rsync -avzh --progress /home/martin/backup/u-postgresql.qcow2 /media/martin/backup/Monthly/ --log-file=/home/martin/rsync.log
sudo rsync -avzh --progress /home/martin/backup/u-jupyter.qcow2 /media/martin/backup/Monthly/ --log-file=/home/martin/rsync.log
sudo rsync -avzh --progress /home/martin/backup/u-mssql.qcow2 /media/martin/backup/Monthly/ --log-file=/home/martin/rsync.log

#sudo rsync -avzh --progress /home/martin/backup/d-infra.qcow2 /media/martin/backup/Monthly/ --log-file=/home/martin/rsync.log
#sudo rsync -avzh --progress /home/martin/backup/ansible.qcow2 /media/martin/backup/Monthly/ --log-file=/home/martin/rsync.log
#sudo rsync -avzh --progress /home/martin/backup/u-apex.qcow2 /media/martin/backup/Monthly/ --log-file=/home/martin/rsync.log
#sudo rsync -avzh --progress /home/martin/backup/d-mssql.qcow2 /media/martin/backup/Monthly/ --log-file=/home/martin/rsync.log
#sudo rsync -avzh --progress /home/martin/backup/gitlab.qcow2 /media/martin/backup/Monthly/ --log-file=/home/martin/rsync.log
#sudo rsync -avzh --progress /home/martin/backup/u-docker.qcow2 /media/martin/backup/Monthly/ --log-file=/home/martin/rsync.log
#sudo rsync -avzh --progress /home/martin/backup/u-srv.qcow2 /media/martin/backup/Monthly/ --log-file=/home/martin/rsync.log