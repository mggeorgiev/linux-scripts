#!/bin/bash

sudo apt-get install stress
sudo stress --cpu 8 --timeout 480 &

sudo apt remove stress