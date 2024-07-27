#!/usr/bin/env bash

SOURCE=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")"/.. &> /dev/null && pwd)
CONFIG="$HOME/.config"
LOCAL="$HOME/.local"

CP_FAILURE='[ERROR] Failed copying files'
LN_FAILURE='[ERROR] Linkage failure'
DL_FAILURE='[ERROR] Download failed'
MK_FAILURE='[ERROR] Failed making directories'

pexit() {
    echo "$1"
    exit 1
}

remove() {
    [[ -f "$1" || -L "$1" ]] && rm -f "$1"
    [[ -d "$1" ]] && rm -Rf "$1"
}

echo '-> Installing fonts'
mkdir -p "$LOCAL/share/fonts" || pexit "$MK_FAILURE"
for i in "$SOURCE"/assets/fonts/*; do
    [[ -d "$i" ]] || continue
    cp -f "$i"/* "$LOCAL/share/fonts" || pexit "$CP_FAILURE"
done

if ! [[ -f "$HOME/git-prompt.sh" ]]; then
    echo '-> Downloading git-prompt bash script'
    curl -so "$HOME/git-prompt.sh" 'https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh' || pexit "$DL_FAILURE"
fi

echo '-> Configuring bash'
ln -sf "$SOURCE/config/bash/bashrc" "$HOME/bashrc"
if ! grep -Fq 'source ~/bashrc' "$HOME/.bashrc"; then
    echo -e '\n[[ -f ~/bashrc ]] && source ~/bashrc' >> "$HOME/.bashrc"
fi

echo '-> inputrc'
ln -sf "$SOURCE/config/bash/inputrc" "$HOME/.inputrc"

CONFIGS=('fontconfig' 'alacritty' 'gtk-3.0' 'i3' 'picom' 'tmux' 'nvim')

for i in "${CONFIGS[@]}"; do
    echo "-> Setting up $i"
    remove "$CONFIG/$i"
    ln -sf "$SOURCE/config/$i" "$CONFIG/$i"
done

echo '-> Installing neovim plugins'
NEOVIM="$LOCAL/share/nvim/site/pack/bezzz/start"
mkdir -p "$NEOVIM" || pexit "$MK_FAILURE"

clone() {
    echo "-> Downloading $1"
    git clone -q "$2" "$NEOVIM/$1" || pexit "$DL_FAILURE"
}

nvimInstall() {
    if [[ -d "$NEOVIM/$1" ]]; then
        read -p ":: A version of $1 is already installed, do you wish to update it? (*YES*/NO): " confirm
        if ! [[ "$confirm" == [nN] || "$confirm" == [nN][oO] ]]; then
            rm -Rf "$NEOVIM/$1"
            clone "$1" "$2"
        else
            echo ":: Ok, ignoring $1"
        fi
    else
        clone "$1" "$2"
    fi
}

nvimInstall 'catppuccin' 'https://github.com/catppuccin/nvim.git'
nvimInstall 'vim-cpp-modern' 'https://github.com/bfrg/vim-cpp-modern.git'

echo ':: All set'
