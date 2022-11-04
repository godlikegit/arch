#!/bin/bash

curl https://raw.githubusercontent.com/godlikegit/arch/master/create.sh -O
curl https://raw.githubusercontent.com/godlikegit/arch/master/init.sh -O

. create.sh

reflector -phttps -ccn > /etc/pacman.d/mirriorlist

pacman -Sy

pacstrap /mnt base linux linux-firmware grub dhcpcd

genfstab -U /mnt >> /mnt/etc/fstab

cp init.sh /mnt

arch-chroot /mnt /bin/bash /init.sh

rm /mnt/init.sh

umount /mnt

$reboot
