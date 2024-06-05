#!/bin/bash

log="/home/georgiem/" #$HOME

# Create a temporary backup snapshot which records changes during backup
#sudo virsh snapshot-create-as --domain u-svr guest-state1 \
#    --diskspec vda,file=/home/georgiem/snapshot/u-svr-overlay1.qcow2 \
#    --disk-only --atomic --quiesce --no-metadata

#
running=($(virsh list --name ))

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

# Now the main image is frozen and the changes are going into /tmp/sda_temp.qcow2

# Do your backup here
sudo virsh suspend u-boinc
sudo rsync -avzh /cache/ /vhd/ /vhdssd/images/ /var/lib/libvirt/images/ /backup_local/vhds --log-file=${log}/.rsyncd.log
sudo virsh resume u-boinc

# Now we commit back data from temp snapshot into the main image
#virsh blockcommit u-svr vda --active --verbose --pivot
# Remove the temporary snapshot file

#sudo rm /home/georgiem/snapshot/u-svr-overlay1.qcow2

#Loop
for n in "${running[@]}"
do
	# Now we commit back data from temp snapshot into the main image
	virsh blockcommit "$n" vda --active --verbose --pivot
	# Remove the temporary snapshot file

	sudo rm /home/georgiem/snapshot/"$n"-overlay1.qcow2
done
