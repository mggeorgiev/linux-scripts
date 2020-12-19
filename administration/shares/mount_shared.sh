#!/bin/bash

#sudo apt install -y cifs-utils

sudo mount -t cifs -o user=georgiem //192.168.88.4/Shared /shared/
