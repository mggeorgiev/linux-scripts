#!/bin/bash

value=$(cat userpass.txt)

sudo docker run --name some-mysql \
	#-v /my/custom:/etc/mysql/conf.d \
	-v ~/mysql:/var/lib/mysql
	-e MYSQL_ROOT_PASSWORD=$value \
	-d mysql:tag
