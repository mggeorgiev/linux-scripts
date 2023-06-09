#!/bin/bash

find /backup_local/ -mindepth 1 -mtime +1000 -type f -depth -print

#find /backup_local/ -mindepth 1 -mtime +1000 -type f -delete