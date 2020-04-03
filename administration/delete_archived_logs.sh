#!/bin/bash

FILE=/etc/resolv.conf


#!/bin/bash
FILES=/backup_local/logs/log_daily/*gz
for f in $FILES
do
  #echo "Processing $f file..."
    if test -f "$FILE"; then
        echo "$FILE exist"
    fi  # take action on each file. $f store current file name
  #cat $f
done