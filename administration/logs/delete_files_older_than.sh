#!/bin/bash

find /backup_local/ -mindepth 1 -mtime +900 -type f -depth -print

sudo find /backup_local/ -mindepth 1 -mtime +900 -type f -delete

<<<<<<< HEAD
find /backup_local/ -mindepth 1 -mtime +900 -type f -depth -print
=======
find /backup_local/ -mindepth 1 -mtime +900 -type f -depth -print
>>>>>>> 06ded7c7d3c03ec6c51b64dcc4c04202708041c5
