#!/bin/bash

FILE=/etc/resolv.conf
if test -f "$FILE"; then
    echo "$FILE exist"
fi