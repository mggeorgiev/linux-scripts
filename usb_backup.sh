#!/bin/bash

if [ "$1" != "" ]; then
    if [ "$1" == "weekly" ]; then 
        sudo mount /dev/sdf1 /attached
        sudo rsync -avzh --progress /backup_local/vhds/ /attached/backup/vhds/Weekly
        sudo umount /attached
    elif [ "$1" == "monthly" ]; then
        sudo mount /dev/sdf1 /attached
        sudo rsync -avzh --progress /backup_local/vhds/ /attached/backup/vhds/Monthly
        sudo umount /attached
    elif [ "$1" == "yearly" ]; then
        sudo mount /dev/sdf1 /attached
        sudo rsync -avzh --progress /backup_local/vhds/ /attached/backup/vhds/Yearly
        sudo umount /attached
    fi
else
    echo "Missing parameter"
    echo "Use bash usb_backup.sh weekly to backup to the weekly directiry"
    echo "Use bash usb_backup.sh monthly to backup to the weekly directiry"
    echo "Use bash usb_backup.sh yearly to backup to the weekly directiry"
fi
