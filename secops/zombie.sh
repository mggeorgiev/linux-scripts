#!/bin/bash

ps axo stat,ppid,pid,comm | grep -w defunct

#zombieid=$(ps axo pid | grep -w defunct)

#echo $zombieid

for p in $(ps jauxww | grep Z | grep -v PID | awk '{print $3}'); do
    for every in $(ps auxw | grep $p | grep cron | awk '{print $2}'); do
        kill -9 $every;
    done;
done;
