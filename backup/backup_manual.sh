#!/bin/bash

log="/home/georgiem/" #$HOME

# Create a temporary backup snapshot which records changes during backup
#sudo virsh snapshot-create-as --domain u-svr guest-state1 \
#    --diskspec vda,file=/home/georgiem/snapshot/u-svr-overlay1.qcow2 \
#    --disk-only --atomic --quiesce --no-metadata

#
running="domain name"

declare -a disks_array=($(for vm in $running; do
    virsh domblklist $vm --details | awk '/disk/{print $4}'
done))

#Loop
for n in "${running[@]}"
do
    echo "Working on $n domain now"
    # do something on $n below, say count line numbers
    # wc -l "$n"

# Create a temporary backup snapshot which records changes during backup
sudo virsh snapshot-create-as --domain "$n" guest-state1 \
    --diskspec vda,file=/home/georgiem/snapshot/"$n"-overlay1.qcow2 \
    --disk-only --atomic --quiesce --no-metadata

done

# Now the main image is frozen and the changes are going into /home/georgiem/snapshot/"$n"-overlay1.qcow2

# Do your backup here
# sudo virsh suspend u-boinc

#Loop
for n in "${disks_array[@]}"
do
    echo "backing $n disk now"

    sudo rsync -avzh "$n" /backup_local/vhds --log-file=${log}.rsyncd.log
done

# sudo virsh resume u-boinc

# Now we commit back data from temp snapshot into the main image
#virsh blockcommit u-svr vda --active --verbose --pivot
# Remove the temporary snapshot file

#sudo rm /home/georgiem/snapshot/u-boinc-overlay1.qcow2

#Loop
for n in "${running[@]}"
do
	# Now we commit back data from temp snapshot into the main image
	echo "Commiting on $n domain now"
	virsh blockcommit "$n" vda --active --verbose --pivot
	# Remove the temporary snapshot file

	sudo rm /home/georgiem/snapshot/"$n"-overlay1.qcow2
done