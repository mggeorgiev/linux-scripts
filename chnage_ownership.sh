#!/bin/bash

sudo chown -R libvirt-qemu:kvm /cache/
sudo chown -R libvirt-qemu:kvm /vhd/
sudo chown -R libvirt-qemu:kvm /vhdssd/images/

sudo chown -R $USER:$USER /cache/
