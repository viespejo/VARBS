#!/bin/bash

blue() { printf "\n\033[0;34m $* \033[0m\n\n" && (echo $* >> /tmp/VARBS.log) ;}
red() { printf "\n\033[0;31m $* \033[0m\n\n" && (echo ERROR: $* >> /tmp/VARBS.log) ;}

NAME=$(whoami)

blue Activating Pulseaudio if not already active...
pulseaudio --start && blue Pulseaudio enabled...

#Install an AUR package manually.
aurinstall() { curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/$1.tar.gz && tar -xvf $1.tar.gz && cd $1 && makepkg --noconfirm -si && cd .. && rm -rf $1 $1.tar.gz ;}

#Install yay manually.
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg --noconfirm -si && cd .. && rm -rf yay

#aurcheck runs on each of its arguments, if the argument is not already installed, it either uses yay to install it, or installs it manually.
aurcheck() {
qm=$(pacman -Qm | awk '{print $1}')
for arg in "$@"
do
if [[ $qm = *"$arg"* ]]; then
	echo $arg is already installed.
else 
	echo $arg not installed
	blue Now installing $arg...
	if [[ -e /usr/bin/yay ]]
	then
		(yay --noconfirm -S $arg && blue $arg now installed) || red Error installing $arg.
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
                                                               

aurcheck i3-gaps zsh zsh-completions i3-gnome-pomodoro-git task-git fpp flameshot-git inputplug ripgrep the_silver_searcher unclutter-xfixes-git rxvt-unicode-patched urxvt-perls urxvt-resize-font-git polybar python-pywal arc-gtk-theme papirus-icon-theme-git xss-lock-git xautolock nodejs lxappearance nerd-fonts-complete-mono-glyphs ttf-material-design-icons ttf-font-awesome dunst-git i3lock screenkey-git xdg-user-dirs openconnect networkmanager-openconnect wine wine_gecko wine-mono heidisql meld || red Error with basic AUR installations...

aurcheck remmina libvncserver freerdp skypeforlinux-preview-bin || red Error with basic AUR installations...

blue Change shell...
chsh -s /bin/zsh

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
cd /home/$NAME/
git clone https://github.com/viespejo/.dotfiles-local.git && cd .dotfiles-local && ./install

cd /home/$NAME/
blue Creating a full suite of localized default user directories
xdg-user-dirs-update
mkdir Documents/Books
