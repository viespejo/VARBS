#Potential variables: timezone, lang and local

passwd

# timezone
ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime

hwclock --systohc

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "es_ES.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# mirrorlist
pacman --noconfirm --needed -S reflector
reflector --verbose -l 5 --sort rate --save /etc/pacman.d/mirrorlist

# enable multilib
multilib=$(grep -n "\[multilib\]" /etc/pacman.conf | cut -f1 -d:)
sed -i "${multilib}s/^#//g" /etc/pacman.conf
multilib=$(($multilib+1))
sed -i "${multilib}s/^#//g" /etc/pacman.conf
pacman -Syy

# NetworkManager
pacman --noconfirm --needed -S networkmanager
systemctl enable NetworkManager
systemctl start NetworkManager

# Intel CPU
pacman --noconfirm --needed -S intel-ucode

# enable magic SysRq key (reisub)
echo "1" > /etc/sysctl.d/90-sysrq.conf

# remember mount the partitions that contain other systems
pacman --noconfirm --needed -S grub efibootmgr os-prober
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=grub && grub-mkconfig -o /boot/grub/grub.cfg

pacman --noconfirm --needed -S dialog
varbs() { curl -LO https://raw.githubusercontent.com/viespejo/VARBS/master/varbs.sh && bash varbs.sh ; }
dialog --title "Install Vicente's Rice" --yesno "This install script will easily let you access Vicente's Auto-Rice Boostrapping Scripts which automatically install a full Arch Linux i3-gaps desktop environment.\n\nIf you'd like to install this, select yes, otherwise select no.\n\nVicente"  15 60 && varbs

