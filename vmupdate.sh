#!/bin/bash

# Read Password
echo -n Password: 
read -s password
echo
# Run Command
echo $password

ssh -t georgiem@mysql /home/georgiem/update.sh
ssh -t georgiem@v001 /home/georgiem/update.sh
ssh -t georgiem@joomla /home/georgiem/update.sh
ssh -t georgiem@splunk /home/georgiem/update.sh
ssh -t georgiem@apex /home/georgiem/update.sh
ssh -t georgiem@mssql /home/georgiem/update.sh
ssh -t georgiem@jupyternb /home/georgiem/update.sh
ssh -t georgiem@postgresql /home/georgiem/update.sh
ssh -t georgiem@boinc /home/georgiem/update.sh
ssh -t georgiem@docker /home/georgiem/update.sh

ssh -t georgiem@192.168.88.51 /home/georgiem/update.sh
ssh -t georgiem@192.168.88.52 /home/georgiem/update.sh

ssh -t georgiem@192.168.88.35 /home/georgiem/update.sh

ssh -t georgiem@192.168.88.31 /home/georgiem/update.sh
ssh -t georgiem@192.168.88.204 /home/georgiem/update.sh


# -     u-boinc                        shut off
# -     u-dobria                       shut off
# -     u-docker                       shut off
# -     u-dotnet                       shut off
# -     u-dotnet-nginx                 shut off
# -     u-dotnet-original              shut off
# -     u-oracle-db                    shut off
# -     u-splunk-free                  shut off
# -     u-svr-cl1                      shut off
# -     u-svr-cl2                      shut off
# -     u-svr-clean                    shut off
# -     u-svr-dev                      shut off
# -     u-svr-dev-bm                   shut off
# -     u-svr-LFS201                   shut off
# -     u-web                          shut off
# -     u-webmin                       shut off
