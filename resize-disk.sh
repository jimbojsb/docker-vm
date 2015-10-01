#!/bin/bash
vagrant halt
olddir=`pwd`
cd ~/VirtualBox\ VMs/coreos-vm
VBoxManage clonehd coreos_production_vagrant_image.vmdk temp.vdi --format vdi
VBoxManage storageattach coreos-vm --storagectl "IDE Controller" --port 0 --device 0 --type hdd --medium none
VBoxManage closemedium disk coreos_production_vagrant_image.vmdk --delete
VBoxManage modifyhd temp.vdi --resize 102400
VBoxManage clonehd temp.vdi coreos_production_vagrant_image.vmdk --format vmdk
VBoxManage closemedium disk temp.vdi --delete
VBoxManage storageattach coreos-vm --storagectl "IDE Controller" --port 0 --device 0 --type hdd --medium coreos_production_vagrant_image.vmdk
cd $olddir
vagrant up