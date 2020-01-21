#!/bin/bash

value=$(cat ~/userpass.txt)

sudo docker run --name some-mysql \
	-v ~/mysql:/var/lib/mysql \
	-e MYSQL_ROOT_PASSWORD=$value \
	-d mysql:tag
