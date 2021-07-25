#!/bin/bash

#for i in {1..50}
for (( ; ; )
do
#	echo "Executed $i times"
#	echo `date +%Y%m%d` `date +%T` $(sensors | awk '/temp1/ ')

	echo `date +%Y%m%d` $(mpstat | awk '/all/') >> cpu.log
	echo `date +%Y%m%d` `date +%T` $(free -m | awk '/Mem:/') >> mem.log
	echo `date +%Y%m%d` `date +%T` $(sensors | awk '/temp1/ ') >> temperature.log

	sleep 30
done
