#!/bin/bash

docker run -d --name telegraf -v $PWD/telegraf.conf:/etc/telegraf/telegraf.conf:ro telegraf