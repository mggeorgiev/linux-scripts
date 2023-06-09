#!/bin/bash

find /backup_local/ -mindepth 1 -mtime +900 -type f -depth -print

sudo find /backup_local/ -mindepth 1 -mtime +900 -type f -delete

find /backup_local/ -mindepth 1 -mtime +900 -type f -depth -print