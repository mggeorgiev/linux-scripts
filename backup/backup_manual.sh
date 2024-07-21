#!/bin/bash

log="/home/georgiem/" #$HOME

running=("domain name1" "domain name2" "domain name3")

declare -a disks_array=($(for vm in $running; do
    virsh domblklist $vm --details | awk '/disk/{print $4}'
done))

#Loop
for n in "${running[@]}"
do
    echo "Create a temporary backup snapshot which records changes during backup of $n domain now"

    sudo virsh snapshot-create-as --domain "$n" guest-state1 \
        --diskspec vda,file=/home/georgiem/snapshot/"$n"-overlay1.qcow2 \
        --disk-only --atomic --quiesce --no-metadata

    # Now the main image is frozen and the changes are going into /home/georgiem/snapshot/"$n"-overlay1.qcow2

    #Loop
    for d in "${disks_array[@]}"
    do
        echo "Backing $d disk now"

        sudo rsync -avzh "$d" /backup_local/vhds --log-file=${log}.rsyncd.log
    done

	# Now we commit back data from temp snapshot into the main image
	echo "Commiting on $n domain now"
	virsh blockcommit "$n" vda --active --verbose --pivot
	# Remove the temporary snapshot file

	sudo rm /home/georgiem/snapshot/"$n"-overlay1.qcow2

done