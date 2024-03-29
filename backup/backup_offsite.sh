#!/bin/bash

if grep -qs '/home/martin/backup' /proc/mounts; then
    echo "Backup drive already mounted."
else
    echo "Mountimg backup drive."
    sudo mount -t cifs //hypervisor.sofia/backup_hyperv/vhds /home/martin/backup -o username=$(cat ~/username),password=$(cat ~/password)
fi
    
TODAYIS=`date +%-d`
echo $TODAYIS
timestamp=$(date +%s)
echo $timestamp

delta() {
    now=$(date +%s)
    delta=$((now - timestamp))
    echo $delta
}

sync_data(){
    delta
    # vmname="u-mysql.qcow2"
    echo $1
    sudo rsync -avzh --progress /home/martin/backup/$1 /media/martin/backup/Monthly/ --log-file=/home/martin/rsync.log    
}

if [[ $((TODAYIS%2)) -eq 1 ]]
then
    echo "Unfreqently chaning vms"

    ## declare an array variable
    declare -a serversArray=("Mikrotik-defconf.qcow2" 
                             "u-mysql.qcow2" 
                             "u-postgresql.qcow2" 
                             "u-splunk-free.qcow2"
                             "u-splunk.qcow2"
                             "u-jupyter.qcow2"
                             "u-mssql.qcow2"
                             "allin.qcow2"
                             "k3d.qcow2"
                             "clearOS.qcow2"
                             )

    ## now loop through the above array
    for i in "${serversArray[@]}"
    do
    echo "$i"
    # or do whatever with individual element of the array
        if [ $((delta)) -lt 60 ]
        then
            sync_data "$i"
        fi
    done

    # You can access them using echo "${arr[0]}", "${arr[1]}" also
else
    if [ $((TODAYIS)) -eq 2 ]
    then
        echo "d-infra.qcow2"
        sudo rsync -avzh --progress /home/martin/backup/d-infra.qcow2 /media/martin/backup/Monthly/ --log-file=/home/martin/rsync.log
    fi
    
    if [ $((TODAYIS)) -eq 4 ]
    then
        echo "ansible.qcow2"
        sudo rsync -avzh --progress /home/martin/backup/ansible.qcow2 /media/martin/backup/Monthly/ --log-file=/home/martin/rsync.log
    fi
    
    if [ $((TODAYIS)) -eq 6 ]
    then
        echo "u-apex.qcow2"
        sudo rsync -avzh --progress /home/martin/backup/u-apex.qcow2 /media/martin/backup/Monthly/ --log-file=/home/martin/rsync.log
    fi
    
    if [ $((TODAYIS)) -eq 10 ]
    then
        echo "d-mssql.qcow2"
        sudo rsync -avzh --progress /home/martin/backup/d-mssql.qcow2 /media/martin/backup/Monthly/ --log-file=/home/martin/rsync.log
    fi
    
    if [ $((TODAYIS)) -eq 12 ]
    then
        echo "gitlab.qcow2"
        sudo rsync -avzh --progress /home/martin/backup/gitlab.qcow2 /media/martin/backup/Monthly/ --log-file=/home/martin/rsync.log
    fi
    
    if [ $((TODAYIS)) -eq 14 ]
    then
        echo "u-docker.qcow2"
        sudo rsync -avzh --progress /home/martin/backup/u-docker.qcow2 /media/martin/backup/Monthly/ --log-file=/home/martin/rsync.log
    fi
    
    if [ $((TODAYIS)) -eq 16 ]
    then
        echo "u-srv.qcow2 "
        sudo rsync -avzh --progress /home/martin/backup/u-srv.qcow2 /media/martin/backup/Monthly/ --log-file=/home/martin/rsync.log
    fi
    
    if [ $((TODAYIS)) -eq 18 ]
    then
        echo "d-infra.qcow2"
        sudo rsync -avzh --progress /home/martin/backup/d-infra.qcow2 /media/martin/backup/Monthly/ --log-file=/home/martin/rsync.log
    fi
    
    if [ $((TODAYIS)) -eq 20 ]
    then
        echo "u-apex.qcow2"
        sudo rsync -avzh --progress /home/martin/backup/u-apex.qcow2 /media/martin/backup/Monthly/ --log-file=/home/martin/rsync.log
    fi
    
    if [ $((TODAYIS)) -eq 22 ]
    then
        echo "d-mssql.qcow2"
        sudo rsync -avzh --progress /home/martin/backup/d-mssql.qcow2 /media/martin/backup/Monthly/ --log-file=/home/martin/rsync.log
    fi
    
    if [ $((TODAYIS)) -eq 24 ]
    then
        echo "gitlab.qcow2"
        sudo rsync -avzh --progress /home/martin/backup/gitlab.qcow2 /media/martin/backup/Monthly/ --log-file=/home/martin/rsync.log
    fi
    
    if [ $((TODAYIS)) -eq 26 ]
    then
        echo "u-docker.qcow2"
        sudo rsync -avzh --progress /home/martin/backup/u-docker.qcow2 /media/martin/backup/Monthly/ --log-file=/home/martin/rsync.log
    fi

    if [ $((TODAYIS)) -eq 28 ]
    then
        echo "u-srv.qcow2 "
        sudo rsync -avzh --progress /home/martin/backup/u-srv.qcow2 /media/martin/backup/Monthly/ --log-file=/home/martin/rsync.log
    fi
fi