#!/bin/bash

cat << EOF >> br10.xml
<network>
  <name>br10</name>
  <forward mode='nat'>
    <nat>
      <port start='1024' end='65535'/>
    </nat>
  </forward>
  <bridge name='br10' stp='on' delay='0'/>
  <ip address='192.168.30.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.30.50' end='192.168.30.200'/>
    </dhcp>
  </ip>
</network>
EOF

sudo virsh net-define  br10.xml
sudo virsh net-start br10

# Parameterize this option
#sudo virsh net-autostart br10

sudo virsh net-list --all

ip addr show dev br10