#!/bin/bash

ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc

echo LANG=en_US.UTF-8 > /etc/locale.conf
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen


echo arch > /etc/hostname

echo "
127.0.0.1	localhost.localdomain	localhost
::1			localhost.localdomain	localhost
127.0.0.1	arch.localdomain 		arch
" >> /etc/hosts


grub-install --recheck /dev/sda

grub-mkconfig -o /boot/grub/grub.cfg

pacman -S vim

echo -e "qweasd\nqweasd" | passwd
