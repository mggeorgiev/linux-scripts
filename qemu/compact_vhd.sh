#!/bin/bash
#sudo qemu-img convert -O qcow2 /vhd/u-jupyter.qcow2 /vhd/u-jupyter.qcow2.compact
#sudo mv /vhd/u-jupyter.qcow2.compact  /vhd/u-jupyter.qcow2

sudo qemu-img convert -O qcow2 /vhdssd/images/u-apex.qcow2 /vhdssd/images/u-apex.qcow2.compact
#sudo mv /vhdssd/images/u-apex.qcow2.compact /vhdssd/images/u-apex.qcow2

#sudo qemu-img convert -O qcow2 /var/lib/libvirt/images/u-jml.qcow2 /var/lib/libvirt/images/u-jml.qcow2.compact
#sudo mv /var/lib/libvirt/images/u-jml.qcow2.compact /var/lib/libvirt/images/u-jml.qcow2

sudo virt-sparsify /vhdssd/images/ansible.qcow2 --compress /vhdssd/images/ansible.qcow2.compact
### edit the domain - virsh edit <domain name>
#sudo mv /vhdssd/images/ansible.qcow2.compact /vhdssd/images/ansible.qcow2
#sudo chown libvirt-qemu:kvm /vhdssd/images/ansible.qcow2