#!/bin.bash

service="parted"

ps -ef | grep $service | grep -v grep | awk '{print $2}' | xargs -r kill -9
ps -ef | grep $service | grep -v grep | awk '{print $2}' | xargs -r kill -9


for pid in $(ps -ef | grep $service | awk '{print $2}'); do kill -9 $pid; done
for pid in $(ps -ef | awk '/${service}/ {print $2}'); do kill -9 $pid; done