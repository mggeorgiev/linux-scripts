#!/bin/bash

if [ "$1" = "" ]
then
  echo Hey you fogot to add a password. {$0} passowrd
else
  groupadd -g 5000 rouser

  useradd -u 5000 -g 5000 -md /home/rouser -c "Azure Migrate Linux User" -s /bin/bash rouser

  passwd rouser $1
fi
