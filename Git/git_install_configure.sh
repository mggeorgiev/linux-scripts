#!/bin/bash
sudo apt-get install git
git config --global user.name "User Name"
git config --global user.email "email@email.com"
git config --global credential.helper store
git config --list
