#!/bin/bash

# Installing Apt-Cacher-NG on the Ubuntu Server 
sudo apt-get install apt-cacher-ng

# Define the config file path
CONFIG_FILE="/etc/apt-cacher-ng/acng.conf"

# Use sed to uncomment the CacheDir line
sudo sed -i 's/^#\s*\(CacheDir:\s*\/var\/cache\/apt-cacher-ng\)/\1/' "$CONFIG_FILE"

# Use sed to uncomment the LogDir line
sudo sed -i 's/^#\s*\(LogDir:\s*\/var\/cache\/apt-cacher-ng\)/\1/' "$CONFIG_FILE"

# Uncomment Port line
sudo sed -i 's/^#\s*\(Port:\s*3142\)/\1/' "$CONFIG_FILE"

# Append BindAddress line to the end of the file
echo "BindAddress: 0.0.0.0" | sudo tee -a "$CONFIG_FILE" > /dev/null