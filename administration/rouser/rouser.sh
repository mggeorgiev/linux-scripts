#!/bin/bash
#If using AzureBastion run with sudo bash rouser.sh (20200817)
#Copying from githib to the bastion clipboard will change the script and it will fail.
#Verify the script manually 


if [ "$1" = "" ]
then
  echo Hey you fogot to add a password. {$0} passowrd
else
  groupadd -g 5000 rouser

  useradd -u 5000 -g 5000 -md /home/rouser -c "Azure Migrate Linux User" -s /bin/bash rouser
  #adduser --home /var/azmgr/specific_folder --shell /bin/bash --no-create-home --ingroup www-data --ingroup ssh rouser

  passwd rouser #$1
fi

