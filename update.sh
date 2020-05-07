#!/bin/bash
sudo apt update
sudo apt list --upgradable

if [ "$1" == "y" ]; then
	sudo apt upgrade -y
else
        # Read User Input
        echo -n "Do you want to proceed? (y/n):"
        read -s proceed
        if [ "$proceed" == "y" ]; then
                echo "Use remove to stop and delete the registry"
                sudo apt upgrade -y
        fi

fi

sudo apt autoremove
