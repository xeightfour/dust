#!/bin/bash

function bounce {
	echo '[ERROR] donno what happened >:' && exit 1
}

if ! [[ -f ~/git-prompt.sh ]]; then
	echo 'Receiving git-prompt.sh...'
	curl -so ~/git-prompt.sh 'https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh' || bounce
fi

pkgs=(acpica alacritty aria2 bash-completion bc cups cpio dosfstools elementary-icon-theme expac fastfetch feh firefox flatpak fmt git glew glfw glm go hexedit htop inetutils jdk-openjdk jdk8-openjdk lib32-mesa lostfiles maim man-pages mousepad mpv nasm nemo neovim net-tools noto-fonts-cjk noto-fonts-emoji ntfs-3g openssh os-prober pacman-contrib picom ranger reflector rofi stow sxiv tmux unzip usbutils vi vim wget xclip xdg-utils zathura zathura-cb zathura-djvu zathura-ps zathura-pdf-mupdf zip)
sudo pacman -Syy ${pkgs[@]}

echo 'All done <:'
