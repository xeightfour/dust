#!/bin/bash

# Just in case
dust=$(cd -- $(dirname -- "${BASH_SOURCE[0]}") &> /dev/null && pwd)

function bounce {
	echo '[ERROR] donno what happened >:' && exit 1
}

# Install shit | outdated as fuck
inst=('alacritty' 'bash-completion' 'bc' 'cups' 'fastfetch' 'feh' 'firefox' 'fmt' 'git' 'glew' 'glfw' 'glm' 'go' 'graphviz' 'hexedit' 'htop' 'i3' 'mousepad' 'mpv' 'nasm' 'neovim' 'net-tools' 'ntfs-3g' 'openssh' 'papirus-icon-theme' 'picom' 'python-pip' 'ranger' 'rofi' 'stow' 'tmux' 'vi' 'vim' 'wget' 'xclip' 'flatpak' 'python-psutil')
sudo pacman -S "${inst[@]}" || bounce

if ! [[ -f ~/git-prompt.sh ]]; then
	echo 'Receiving git-prompt.sh...'
	curl -so ~/git-prompt.sh 'https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh' || bounce
fi

echo 'All done <:'
