#!/bin/bash

value=$(cat userpass.txt)

case $1 in
  2017 )
      sudo docker stop sql${1} && sudo docker rm sql${1}
      sudo docker run -e "ACCEPT_EULA=Y' -e 'SA_PASSWORD=${value}" \
         --restart=always \
         -v /home/georgiem/mssql:/var/opt/mssql/data \
         -p 1433:1433 --name sql${1} \
         -d mcr.microsoft.com/mssql/server:2017-latest
	;;
  2019 )
      sudo docker stop sql${1} && sudo docker rm sql${1}
      sudo docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=${value}" \
         -p 1431:1433 \
         --name sql${1} \
         --volume mssqlsystem:/var/opt/mssql \
         --volume mssqluser:/var/opt/sqlserver \
         --restart=unless-stopped \
         -d mcr.microsoft.com/mssql/server:2019-latest
	;;
   2022 )
      sudo docker stop sql${1} && sudo docker rm sql${1}
      sudo docker run -e "ACCEPT_EULA=Y' -e 'SA_PASSWORD=${value}" \
         --restart=always \
         -v /home/georgiem/mssql:/var/opt/mssql/data \
         -p 1433:1433 --name sql${1} \
         -d mcr.microsoft.com/mssql/server:2022-latest
	;;
   2025 )
      sudo docker stop sql${1} && sudo docker rm sql${1}
      sudo docker run -e "ACCEPT_EULA=Y' -e 'SA_PASSWORD=${value}" \
         --restart=always \
         -v /home/georgiem/mssql:/var/opt/mssql/data \
         -p 1433:1433 --name sql${1} \
         -d mcr.microsoft.com/mssql/server:2025-latest
	;;
   * )
	echo "Missing parameter"
	echo "Use 'bash docker-mssql.sh 2022' to start a MSSQL 2022 docker instance"
	echo "Use 'bash docker-mssql.sh 2025' to start a MSSQL 2025 docker instance"
   	;;
esac

sudo docker ps -a

#Single user mode
#sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=${value}' \
#   -v /home/georgiem/mssql:/mssql \
#   -p 1432:1433 --name sql-sum \
#   -d mcr.microsoft.com/mssql/server:2017-CU14-ubuntu \
#   "/opt/mssql/bin/sqlservr" "-m"

#docker run -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=<YourStrong!Passw0rd>' -p 1433:1433 -v <host directory>:/var/opt/mssql -d mcr.microsoft.com/mssql/server:2019-GA-ubuntu-16.04

#sudo docker start --name sq1

#remove
#sudo docker stop sql1
#sudo docker rm sql1
