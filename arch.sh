#!/bin/bash

#This is a lazy script I have for auto-installing Arch.

pacman -S --noconfirm dialog || (echo "Error at script start: Are you sure you're running this as the root user? Are you sure you have an internet connection?" && exit)
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

dialog --defaultno --title "DON'T BE A BRAINLET!" --yesno "\nThis is an Arch install script that is very rough around the edges. This script is only really for me so I can autoinstall Arch.\n\nVicente Espejo"  10 60 || exit

dialog --no-cancel --inputbox "Enter a name for your computer." 10 60 2> comp

# Update the system clock
timedatectl set-ntp true

# Partition the disks
# fdisk -l
# gdisk /dev/sdx

# Format the partition
# mkfs.ext4 /dev/sda1

# Mount the file systems
# mount /dev/sda1 /mnt
# mkdir -p /mnt/boot/efi
# mount /dev/sda2 /mnt/boot/efi

# Install the base packages
pacstrap /mnt base base-devel

# Fstab
genfstab -U /mnt >> /mnt/etc/fstab

#Chroot
curl https://raw.githubusercontent.com/viespejo/VARBS/master/chroot.sh > /mnt/chroot.sh && arch-chroot /mnt bash chroot.sh && rm /mnt/chroot.sh

cat comp > /mnt/etc/hostname
echo "127.0.1.1   $(cat comp).localdomain $(cat comp)" >> /mnt/etc/hosts && rm comp

dialog --defaultno --title "Final Qs" --yesno "Eject CD/ROM (if any)?"  5 30 && eject
dialog --defaultno --title "Final Qs" --yesno "Reboot computer?"  5 30 && reboot
dialog --defaultno --title "Final Qs" --yesno "Return to chroot environment?"  6 30 && arch-chroot /mnt
clear
