#!/bin/bash

blue() { printf "\n\033[0;34m $* \033[0m\n\n" && (echo $* >> /tmp/VARBS.log) ;}
red() { printf "\n\033[0;31m $* \033[0m\n\n" && (echo ERROR: $* >> /tmp/VARBS.log) ;}

NAME=$(whoami)

blue Activating Pulseaudio if not already active...
pulseaudio --start && blue Pulseaudio enabled...

#Install an AUR package manually.
aurinstall() { curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/$1.tar.gz && tar -xvf $1.tar.gz && cd $1 && makepkg --noconfirm -si && cd .. && rm -rf $1 $1.tar.gz ;}

#aurcheck runs on each of its arguments, if the argument is not already installed, it either uses packer to install it, or installs it manually.
aurcheck() {
qm=$(pacman -Qm | awk '{print $1}')
for arg in "$@"
do
if [[ $qm = *"$arg"* ]]; then
	echo $arg is already installed.
else 
	echo $arg not installed
	blue Now installing $arg...
	if [[ -e /usr/bin/packer ]]
	then
		(packer --noconfirm -S $arg && blue $arg now installed) || red Error installing $arg.
	else
		(aurinstall $arg && blue $arg now installed) || red Error installing $arg.
	fi

fi
done
}


blue Installing AUR programs...
blue \(This may take some time.\)

cat << "EOF"
   [0;1;33;93mm[0;1;32;92mm[0m   [0;1;34;94mm[0m    [0;1;31;91mm[0m [0;1;33;93mm[0;1;32;92mmm[0;1;36;96mmm[0m        [0;1;32;92mmm[0;1;36;96mmm[0;1;34;94mmm[0;1;35;95mm[0m [0;1;31;91mmm[0;1;33;93mmm[0;1;32;92mm[0m  [0;1;36;96mm[0m    [0;1;31;91mm[0m [0;1;33;93mmm[0;1;32;92mmm[0;1;36;96mmm[0m   [0;1;35;95mm[0m   
   [0;1;32;92m#[0;1;36;96m#[0m   [0;1;35;95m#[0m    [0;1;33;93m#[0m [0;1;32;92m#[0m   [0;1;34;94m"[0;1;35;95m#[0m          [0;1;34;94m#[0m      [0;1;32;92m#[0m    [0;1;34;94m#[0;1;35;95m#[0m  [0;1;31;91m#[0;1;33;93m#[0m [0;1;32;92m#[0m        [0;1;31;91m#[0m   
  [0;1;36;96m#[0m  [0;1;34;94m#[0m  [0;1;31;91m#[0m    [0;1;32;92m#[0m [0;1;36;96m#[0;1;34;94mmm[0;1;35;95mmm[0;1;31;91m"[0m          [0;1;35;95m#[0m      [0;1;36;96m#[0m    [0;1;35;95m#[0m [0;1;31;91m#[0;1;33;93m#[0m [0;1;32;92m#[0m [0;1;36;96m#m[0;1;34;94mmm[0;1;35;95mmm[0m   [0;1;33;93m#[0m   
  [0;1;34;94m#m[0;1;35;95mm#[0m  [0;1;33;93m#[0m    [0;1;36;96m#[0m [0;1;34;94m#[0m   [0;1;31;91m"[0;1;33;93mm[0m          [0;1;31;91m#[0m      [0;1;34;94m#[0m    [0;1;31;91m#[0m [0;1;33;93m"[0;1;32;92m"[0m [0;1;36;96m#[0m [0;1;34;94m#[0m        [0;1;32;92m"[0m   
 [0;1;34;94m#[0m    [0;1;33;93m#[0m [0;1;32;92m"m[0;1;36;96mmm[0;1;34;94mm"[0m [0;1;35;95m#[0m    [0;1;32;92m"[0m          [0;1;33;93m#[0m    [0;1;34;94mmm[0;1;35;95m#m[0;1;31;91mm[0m  [0;1;33;93m#[0m    [0;1;34;94m#[0m [0;1;35;95m#m[0;1;31;91mmm[0;1;33;93mmm[0m   [0;1;36;96m#[0m   
EOF
                                                               

aurcheck packer yaourt i3-gaps zsh zsh-completions ripgrep the_silver_searcher unclutter-xfixes-git rxvt-unicode-patched urxvt-perls urxvt-resize-font-git polybar python-pywal arc-gtk-theme papirus-icon-theme-git xss-lock-git xautolock nodejs npm lxappearance nerd-fonts-complete-mono-glyphs ttf-material-design-icons noto-fonts ttf-font-awesome dunst-git i3lock screenkey-git xdg-user-dirs openconnect networkmanager-openconnect || red Error with basic AUR installations...

choices=$(cat /tmp/.choices)
for choice in $choices
do
    case $choice in
    4)
		aurcheck spotify
        ;;
	6)
        aurcheck ttf-google-fonts-git
	    ;;
	8)
		aurcheck bash-pipes cli-visualizer speedometer neofetch
		;;
    esac
done
cat << "EOF"

         ▄              ▄
        ▌▒█           ▄▀▒▌
        ▌▒▒▀▄       ▄▀▒▒▒▐
       ▐▄▀▒▒▀▀▀▀▄▄▄▀▒▒▒▒▒▐
     ▄▄▀▒▒▒▒▒▒▒▒▒▒▒█▒▒▄█▒▐
   ▄▀▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▀██▀▒▌
  ▐▒▒▒▄▄▄▒▒▒▒▒▒▒▒▒▒▒▒▒▀▄▒▒▌
  ▌▒▒▐▄█▀▒▒▒▒▄▀█▄▒▒▒▒▒▒▒█▒▐
 ▐▒▒▒▒▒▒▒▒▒▒▒▌██▀▒▒▒▒▒▒▒▒▀▄▌
 ▌▒▀▄██▄▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▌
 ▌▀▐▄█▄█▌▄▒▀▒▒▒▒▒▒░░░░░░▒▒▒▐
▐▒▀▐▀▐▀▒▒▄▄▒▄▒▒▒▒▒░░░░░░▒▒▒▒▌
▐▒▒▒▀▀▄▄▒▒▒▄▒▒▒▒▒▒░░░░░░▒▒▒▐
 ▌▒▒▒▒▒▒▀▀▀▒▒▒▒▒▒▒▒░░░░▒▒▒▒▌
 ▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▐
  ▀▄▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▄▒▒▒▒▌
    ▀▄▒▒▒▒▒▒▒▒▒▒▄▄▄▀▒▒▒▒▄▀
   ▐▀▒▀▄▄▄▄▄▄▀▀▀▒▒▒▒▒▄▄▀
  ▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▀▀

EOF

browsers=$(cat /tmp/.browch)
for choice in $browsers
do
	case $choice in
		3)
			aurcheck google-chrome
			;;
	esac
done

blue Downloading config files...
cd /home/$NAME/
git clone https://github.com/viespejo/.dotfiles.git && cd .dotfiles && ./install

blue Local udev rules
cp udev.d/90-local.rules /etc/udev/rules.d/

blue Creating a full suite of localized default user directories
xdg-user-dirs-update
