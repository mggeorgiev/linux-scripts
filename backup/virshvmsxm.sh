#!/bin/bash
# Declare an array of virsh vms
declare -a HostsArray=$(virsh list --name --all)

mkdir -p ~/virshxmlbackup

# Iterate the array using for loop backing up the xml for each guest
for vm in ${HostsArray[@]}; do
   echo "Backing up ${vm}"
   virsh dumpxml $vm > ~/virshxmlbackup/${vm}.xml
done
