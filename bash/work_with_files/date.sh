#!/bin/bash

TZ=UTC

#! -z "$1" is not empty string
if [ ! $# -eq 0 ]; then 
    if [ $1 = "append" ]; then
        date >> date.txt
    fi
else
    date > date.txt
fi

echo $( < date.txt )