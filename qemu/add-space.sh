sudo qemu-img resize u-splunk-free.qcow2 +20G
sudo virt-resize -d --expand /dev/sda2 --LV-expand /dev/ubuntu-maas-vg/root u-splunk-free-orig.qcow2 u-splunk-free.qcow2
sudo virt-filesystems --partitions --long -a u-splunk-free-orig.qcow2


