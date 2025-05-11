#!/bin/bash


#file="u-svr"
read file
ext=".qcow2"

#shrink filesize
#sudo virt-sparsify /vhdssd/images/d-mssql.qcow2 --compress /vhdssd/images/d-mssql.qcow2.compact
sudo qemu-img convert -O qcow2 $file$ext $file$file_compact$ext

sudo virt-sparsify --verbose /vhdssd/images/d-mssql.qcow2 --compress /vhdssd/images/d-mssql.qcow2.compact 
sudo virt-sparsify --verbose --in-place /vhdssd/images/u-mysql.qcow2
sudo virt-sparsify --in-place /vhdssd/images/u-splunk.qcow2
sudo virt-sparsify --in-place /vhdssd/images/u-splunk-free.qcow2

sudo virt-sparsify /vhdssd/images/gitlab.qcow2 --compress /vhdssd/images/gitlab.qcow2.compact 

sudo virt-sparsify --in-place /vhdssd/images/u-splunk-free.qcow2