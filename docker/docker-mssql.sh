#!/bin/bash

#sudo docker pull microsoft/mssql-server-linux:2017-latest7
#sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Agent68@IMRO!' \
#   -v /home/georgiem/mssql:/mssql \
#   -p 1433:1433 --name sql1 \
#   -d microsoft/mssql-server-linux:2017-latest

#sudo docker run --restart=always -d jupyter/datascience-notebook

sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Agent68@IMRO!' \
   --restart=always \
   -v /home/georgiem/mssql:/mssql \
   -p 1433:1433 --name sql1 \
   -d microsoft/mssql-server-linux:2017-latest

#sudo docker start --name sq1

#remove
#sudo docker stop sql1
#sudo docker rm sql1
