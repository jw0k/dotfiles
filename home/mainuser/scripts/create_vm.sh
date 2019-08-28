#!/usr/bin/env bash

set -e # stop on first error

if [ "$#" -ne 2 ]; then
    me=`basename "$0"`
    echo "Usage: $me vm_name path_to_iso"
    exit 1
fi

#run vboxmanage list ostypes to get all OS types
vboxmanage createvm --name $1 --ostype ArchLinux_64 --register

vboxmanage modifyvm $1 --memory 2048
vboxmanage createhd --filename "$HOME/VirtualBox VMs/$1/$1.vdi" --size 100000 --format VDI
vboxmanage storagectl $1 --name "SATA Controller" --add sata --controller IntelAhci
vboxmanage storageattach $1 --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$HOME/VirtualBox VMs/$1/$1.vdi"
vboxmanage storagectl $1 --name "IDE Controller" --add ide --controller PIIX4
vboxmanage storageattach $1 --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium $2
#vboxmanage modifyvm $1 --vrde on
#vboxmanage modifyvm $1 --vrdemulticon on --vrdeport 3390
vboxmanage modifyvm $1 --vram 128
vboxmanage modifyvm $1 --graphicscontroller vmsvga
vboxmanage modifyvm $1 --usbohci on
vboxmanage modifyvm $1 --accelerate3d on
#vboxmanage modifyvm $1 --accelerate2dvideo on
vboxmanage modifyvm $1 --cpus 4
vboxmanage modifyvm $1 --monitorcount 1
