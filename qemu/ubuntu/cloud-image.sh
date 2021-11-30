#!/bin/bash

### The script is based on Artem Vasilyev tutorial

hostname="ubuntu2004"

### Download the current image
#wget https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64-disk-kvm.img

###Inspect the image
qemu-img info focal-server-cloudimg-amd64-disk-kvm.img

###Rename the image
sudo mv focal-server-cloudimg-amd64-disk-kvm.img focal-server-cloudimg-amd64-disk-kvm.qcow2 

### Create a disk image
### Using a base image
sudo qemu-img create -f qcow2 -o backing_file=focal-server-cloudimg-amd64-disk-kvm.qcow2 $hostname.qcow2

### Creating a new disk
sudo qemu-img convert -O qcow2 focal-server-cloudimg-amd64-disk-kvm.qcow2 $hostname.qcow2

### Inspect

sudo qemu-img info $hostname.qcow2

###Resize the image
sudo qemu-img resize $hostname.qcow2 5G

#Create meta-data
cat >meta-data <<EOF
local-hostname: $hostname
EOF

#Read public key into environment variable
export PUB_KEY=$(cat ~/.ssh/id_rsa.pub)

### Create user-data
cat >user-data <<EOF
#cloud-config
users:
  - name: ubuntu
    passwd: $6$j212wezy$7H/1LT4f9/N3wpgNunhsIqtMj62OKiS3nyNwuizouQc3u7MbYCarYeAHWYPYb2FT.lbioDm2RrkJPb9BZMN1O/
    ssh-authorized-keys:
      - $PUB_KEY
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    groups: sudo
    shell: /bin/bash
runcmd:
  - echo "AllowUsers ubuntu" >> /etc/ssh/sshd_config
  - restart ssh
EOF

### Generate iso image
sudo genisoimage  -output $hostname-cidata.iso -volid cidata -joliet -rock user-data meta-data

###Start the vm

sudo virt-install --connect qemu:///system \
                  --virt-type kvm \
                  --name $hostname \
                  --ram 2048 \
                  --vcpus=1 \
                  --os-type linux \
                  --os-variant ubuntu20.04 \
                  --disk path=$hostname.qcow2,format=qcow2 \
                  --cdrom=$hostname-cidata.iso \
                  --import \
                  --network network=default \
                  --noautoconsole

# sudo virt-install --connect qemu:///system \
#                   --virt-type kvm \
#                   --name $hostname \
#                   --ram 2048 \
#                   --vcpus=1 \
#                   --os-type linux \
#                   --os-variant ubuntu20.04 \
#                   --disk path=$hostname.qcow2,format=qcow2 \
#                   --disk $hostname-cidata.iso,device=cdrom \
#                   --import --network network=default \
#                   --noautoconsole

sudo virt-install --name=$hostname \
--vcpus=1 \
--memory=1024 \
--cdrom=/tmp/debian-9.0.0-amd64-netinst.iso \
--disk size=5 \
--os-variant=debian8

###
sudo virsh list

###
sudo virsh domifaddr $hostname