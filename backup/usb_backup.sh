#!/bin/bash

source="/backup_local/vhds/"
target="/attached/backup/vhds/"
log="/home/georgiem/" #$HOME

case $1 in
  weekly )
  	echo "weekly"
	target+="Wearly"
	run="true"
	;;
  monthly )
  	echo "monthly"
	target+="Monthly"
	run="true"
	;;
  yearly )
  	echo "yearly"
	target+="Mearly"
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
        sudo mount /dev/sdf1 /attached
	sudo virsh suspend u-boinc
        sudo rsync -avzh --progress $source $target --log-file=${log}/.rsyncd.log
	sudo virch resume u-boinc
        sudo umount /attached
fi
