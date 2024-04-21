#!/bin/bash

source="/backup_local/vhds/"
target="/attached/backup/vhds/"
log="/home/georgiem/" #$HOME

case $1 in
  weekly )
  	echo "weekly"
	target+="Weekly"
	run="true"
	;;
  monthly )
  	echo "monthly"
	target+="Monthly"
	run="true"
	;;
  yearly )
  	echo "yearly"
	target+="Yearly"
	run="true"
	;;
   * )
	echo "Missing parameter"
	echo "Use 'bash usb_backup.sh weekly' to backup to the weekly directiry"
	echo "Use 'bash usb_backup.sh monthly' to backup to the monthly directiry"
	echo "Use 'bash usb_backup.sh yearly' to backup to the yearly directiry"
   	;;
esac

if [ "$run" == "true" ]; then
	#FCB67C4EB67C0B80
	sudo mount UUID=FCB67C4EB67C0B80 /attached
        #sudo mount /dev/sde1 /attached
	sudo virsh suspend u-boinc
        sudo rsync -avzh --progress $source $target --log-file=${log}/rsync.log
	sudo virsh resume u-boinc
        sudo umount /attached
fi
