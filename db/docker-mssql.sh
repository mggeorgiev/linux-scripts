#!/bin/bash

value=$(cat userpass.txt)

#sudo docker pull microsoft/mssql-server-linux:2017-latest7
#sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=${value}' \
#   -v /home/georgiem/mssql:/mssql \
#   -p 1433:1433 --name sql1 \
#   -d microsoft/mssql-server-linux:2017-latest

#Single user mode
#sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=${value}' \
#   -v /home/georgiem/mssql:/mssql \
#   -p 1432:1433 --name sql-sum \
#   -d mcr.microsoft.com/mssql/server:2017-CU14-ubuntu \
#   "/opt/mssql/bin/sqlservr" "-m"

#sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=${value}' \
#   --restart=always \
#   -v /home/georgiem/mssql:/var/opt/mssql/data \
#   -p 1433:1433 --name sql3 \
#   -d mcr.microsoft.com/mssql/server:2017-latest-ubuntu

#sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=${value}' \
#   --restart=unless-stopped \
#   -v /home/georgiem/mssql19:/var/opt/mssql/data \
#   -p 1434:1433 --name sql4 \
#   -d mcr.microsoft.com/mssql/server:2019-GA-ubuntu-16.04

#docker run -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=<YourStrong!Passw0rd>' -p 1433:1433 -v <host directory>:/var/opt/mssql -d mcr.microsoft.com/mssql/server:2019-GA-ubuntu-16.04

sudo docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=${value}" \
   -p 1431:1433 \
   --name sql1 \
   --volume mssqlsystem:/var/opt/mssql \
   --volume mssqluser:/var/opt/sqlserver \
   --restart=unless-stopped \
   -d mcr.microsoft.com/mssql/server:2019-GA-ubuntu-16.04

#sudo docker container run -d -p 1434:1433 \
#--volume mssqlsystem:/var/opt/mssql \
#--env ACCEPT_EULA=Y \
#--env 'SA_PASSWORD=${value}' \
#--name testcontainer \
#mcr.microsoft.com/mssql/server:2019-GA-ubuntu-16.04

#docker container run -d -p 16110:1433 \
#--volume mssqlsystem:/var/opt/mssql \
#--volume mssqluser:/var/opt/sqlserver \
#--env ACCEPT_EULA=Y \
#--env SA_PASSWORD=Testing1122 \
#--name testcontainer \
#mcr.microsoft.com/mssql/server:2019-CTP2.3-ubuntu

#sudo docker start --name sq1

#remove
#sudo docker stop sql1
#sudo docker rm sql1
