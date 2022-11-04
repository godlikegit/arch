#!/bin/bash

function c8G () {

	fdisk /dev/sda <<EOF
n
p
1

+1G
n
p
2

+1G
n
p
3

+2G
n
p


w
EOF
}

function c16G () {

	fdisk /dev/sda <<EOF
n
p
1

+2G
n
p
2

+1G
n
p
3

+3G
n
p


w
EOF
}

function c32G () {

	fdisk /dev/sda <<EOF
n
p
1

+4G
n
p
2

+1G
n
p
3

+10G
n
p


w
EOF
}

function c64G () {

	fdisk /dev/sda <<EOF
n
p
1

+4G
n
p
2

+1G
n
p
3

+30G
n
p


w
EOF
}

function c128G() {

	fdisk /dev/sda <<EOF
n
p
1

+8G
n
p
2

+1G
n
p
3

+50G
n
p


w
EOF
}

function cMore() {

	fdisk /dev/sda <<EOF
n
p
1

+16G
n
p
2

+1G
n
p
3

+100G
n
p


w
EOF
}

function delete_partition_table () {

	swapoff /dev/sda1
	umount -f /dev/sda2
	umount -f /dev/sda3
	umount -f /dev/sda4

	#fdisk /dev/sda &>/dev/null <<EOF
	fdisk /dev/sda <<EOF
d

d

d

d
w
EOF
}


# del old table
delete_partition_table

# get disk size
SDA_SIZE=`lsblk /dev/sda | grep "sda\s" | awk '{print $4}'`

# partition
case $SDA_SIZE in
	"8G")
		c8G
		;;
	"16G")
		c16G
		;;
	"32G")
		c32G
		;;
	"64G")
		c64G
		;;
	"128G")
		c128G
		;;
	*)
		cMore
		;;
esac

# format
mkswap /dev/sda1
mkfs.ext4 /dev/sda2
mkfs.ext4 /dev/sda3
mkfs.ext4 /dev/sda4

# mount
swapon /dev/sda1
mount /dev/sda4 /mnt
mkdir /mnt/home
mkdir /mnt/root
mount /dev/sda3 /mnt/home
mount /dev/sda2 /mnt/root


lsblk /dev/sda
