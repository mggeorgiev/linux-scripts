#!/bin/bash

#FILE=/etc/resolv.conf
FILES=/backup_local/logs/log_daily/*gz
for f in $FILES
do
  #echo "Processing $f file..."
    FILE=${f::-3}
    #echo "Processing $FILE file..."
    if test -f "$FILE"; then
        echo "$FILE exist"
        sudo mv "$FILE" /backup_local/logs/log_daily/temp/
        echo "$FILE deleted"
    fi  # take action on each file. $f store current file name
  #cat $f
done