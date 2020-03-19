#!/bin/bash

case $1 in
  update )
  	echo "update"
	  param1="update"
	  run="true"
	;;
  reset )
  	echo "reset"
	  param1="reset"
	  run="true"
	;;
  resume )
  	echo "resume"
	param1="resume"
	run="true"
	;;
   * )
	echo "Missing parameter"
	echo "Use 'bash boinc.sh update' to contact scheduling server"
	echo "Use 'bash usb_backup.sh reset' to delete current work and get more"
	echo "Use 'bash usb_backup.sh resume' to resume"
   	;;
esac

if [ "$run" == "true" ]; then
  for url in $(boinccmd --get_project_status | sed -n 's/\s*master URL: //p'); do
    boinccmd --project ${url} $param1;
  done
fi
