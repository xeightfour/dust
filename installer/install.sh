#!/usr/bin/env bash

dirHome=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." &> /dev/null && pwd)
dirConfig="$HOME/.config"
dirLocal="$HOME/.local"

dirNeovim="$dirLocal/share/nvim/site/pack/bezzz/start"

errcp='[ERROR] Failed copying files'
errln='[ERROR] Linkage failure'
errdl='[ERROR] Download failed'
errmk='[ERROR] Failed creating directories'

function kExit() {
    echo "$1"
    exit 1
}

function kRemove() {
    [[ -f "$1" || -L "$1" ]] && rm -f "$1"
    [[ -d "$1" ]] && rm -Rf "$1"
}

function kClone() {
    echo ":: Receiving $1"
    git clone -q "$2" "$dirNeovim/$1" || kExit "$errdl"
}

function kInstall() {
    local update=true
    if [[ -d "$dirNeovim/$1" ]]; then
        read -p ">> Some version of $1 is already installed, do you wish to update it? (*YES*/NO): " confirm
        if [[ "$confirm" == [nN] || "$confirm" == [nN][oO] ]]; then
            update=false
        fi
    fi
    if [[ "$update" == true ]]; then
        rm -Rf "$dirNeovim/$1"
        kClone "$1" "$2"
    else
        echo ":: Ok, ignoring $1"
    fi
}

mkdir -p "$dirLocal/share/fonts" || kExit "$errmk"
for i in "$dirHome/assets/fonts"/*; do
    [[ -d "$i" ]] || continue
    cp -f "$i"/* "$dirLocal/share/fonts" || kExit "$errcp"
done

if ! [[ -f "$HOME/git-prompt.sh" ]]; then
    echo ':: Receiving git-prompt.sh script'
    curl -so "$HOME/git-prompt.sh" 'https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh' || kExit "$errdl"
fi

ln -sf "$dirHome/config/bash/bashrc" "$HOME/bashrc" || kExit "$errln"
if ! grep -Fq 'source ~/bashrc' "$HOME/.bashrc"; then
    echo -e '\n[[ -f ~/bashrc ]] && source ~/bashrc' >> "$HOME/.bashrc"
fi

ln -sf "$dirHome/config/bash/inputrc" "$HOME/.inputrc" || kExit "$errln"

array=('fontconfig' 'alacritty' 'gtk-3.0' 'i3' 'picom' 'tmux' 'nvim')

for i in "${array[@]}"; do
    kRemove "$dirConfig/$i"
    ln -sf "$dirHome/config/$i" "$dirConfig/$i" || kExit "$errln"
done

echo ':: Installing Neovim plugins'
mkdir -p "$dirNeovim" || kExit "$errmk"

kInstall 'catppuccin' 'https://github.com/catppuccin/nvim.git'
kInstall 'vim-cpp-modern' 'https://github.com/bfrg/vim-cpp-modern.git'

echo ':: All done(:'
