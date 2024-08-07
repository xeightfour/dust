#!/usr/bin/env bash

dirHome=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
dirConfig="$HOME/.config"
dirLocal="$HOME/.local"
dirNvim="$dirLocal/share/nvim/site/pack/bezzz/start"

cpERR='[ERROR] Failed copying files'
lnERR='[ERROR] Linkage failure'
dlERR='[ERROR] Download failed'
mkERR='[ERROR] Failed creating directories'

function bounce() {
    echo "$1"
    exit 1
}

function remove() {
    [[ -f "$1" || -L "$1" ]] && rm -f "$1"
    [[ -d "$1" ]] && rm -rf "$1"
}

function clone() {
    echo ":: Cloning $1 into $dirNvim/$1"
    git clone -q "$2" "$dirNvim/$1" || bounce "$dlERR"
}

function nvimInstall() {
    local update=true
    if [[ -d "$dirNvim/$1" ]]; then
        read -p ">> Some version of $1 is already installed, do you wish to update it? (*YES*/NO): " confirm
        if [[ "$confirm" == [nN] || "$confirm" == [nN][oO] ]]; then
            update=false
        fi
    fi
    if [[ "$update" == true ]]; then
        remove "$dirNvim/$1"
        clone "$1" "$2"
    else
        echo ":: Ok, ignoring $1"
    fi
}

# Install fonts
mkdir -p "$dirLocal/share/fonts" || bounce "$mkERR"
for i in "$dirHome/assets/fonts"/*; do
    [[ -d "$i" ]] || continue
    cp -f "$i"/* "$dirLocal/share/fonts" || bounce "$cpERR"
done

# Get git-prompt.sh
if ! [[ -f "$HOME/git-prompt.sh" ]]; then
    echo ':: Receiving git-prompt.sh'
    curl -so "$HOME/git-prompt.sh" 'https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh' || bounce "$dlERR"
fi

# Source bashrc
if ! grep -Fq 'source ~/bashrc' "$HOME/.bashrc"; then
    echo -e '\n[[ -f ~/bashrc ]] && source ~/bashrc' >> "$HOME/.bashrc"
fi
# Link bashrc
remove "$HOME/bashrc"
ln -sf "$dirHome/config/bash/bashrc" "$HOME/bashrc" || bounce "$lnERR"

# Link inputrc
remove "$HOME/.inputrc"
ln -sf "$dirHome/config/bash/inputrc" "$HOME/.inputrc" || bounce "$lnERR"

# Link configz
array=('fontconfig' 'alacritty' 'gtk-3.0' 'i3' 'picom' 'tmux' 'nvim')
for i in "${array[@]}"; do
    remove "$dirConfig/$i"
    ln -sf "$dirHome/config/$i" "$dirConfig/$i" || bounce "$lnERR"
done

# Install Neovim plugins
echo ':: Installing plugins for Neovim'
mkdir -p "$dirNvim" || bounce "$mkERR"
nvimInstall 'catppuccin' 'https://github.com/catppuccin/nvim.git'
nvimInstall 'vim-cpp-modern' 'https://github.com/bfrg/vim-cpp-modern.git'

echo ':: All done(:'
