#!/bin/bash

SRC=$(cd ../ && pwd)/src
CFG=~/.config
LCL=~/.local

# Process assets
echo "-> Copying font files"
mkdir -p $LCL/share/fonts
cp --force $SRC/assets/fonts/SFMono/* $LCL/share/fonts
cp --force $SRC/assets/fonts/Iranian/* $LCL/share/fonts
cp --force $SRC/assets/fonts/SXMono/* $LCL/share/fonts

# Set up bash configuration
if [[ ! -f ~/git-prompt.sh ]]; then
    echo "-> Downloading git-prompt bash script"
    curl -so ~/git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh || echo "[ERROR] Failed to download git-prompt"
fi
echo "-> Linking bash configuration"
ln -sf $SRC/config/bash/bashrc ~/bashrc
if ! grep -Fq "source ~/bashrc" ~/.bashrc; then
    echo -e "\n[[ -f ~/bashrc ]] && source ~/bashrc" >> ~/.bashrc
fi

echo "-> Linking inputrc"
ln -sf $SRC/config/bash/inputrc ~/.inputrc

# Link fontconfig
echo "-> Linking fontconfig"
[[ -f $CFG/fontconfig ]] && rm -f $CFG/fontconfig
[[ -d $CFG/fontconfig ]] && rm -Rf $CFG/fontconfig
ln -sf $SRC/config/fontconfig $CFG/fontconfig

# Link alacritty configuration
echo "-> Linking alacritty configuration"
[[ -f $CFG/alacritty ]] && rm -f $CFG/alacritty
[[ -d $CFG/alacritty ]] && rm -Rf $CFG/alacritty
ln -sf $SRC/config/alacritty $CFG/alacritty

# Link GTK-3.0 configuration
echo "-> Linking GTK-3.0 configuration"
[[ -f $CFG/gtk-3.0 ]] && rm -f $CFG/gtk-3.0
[[ -d $CFG/gtk-3.0 ]] && rm -Rf $CFG/gtk-3.0
ln -sf $SRC/config/gtk-3.0 $CFG/gtk-3.0

# Link i3 configuration
echo "-> Linking i3 configuration"
[[ -f $CFG/i3 ]] && rm -f $CFG/i3
[[ -d $CFG/i3 ]] && rm -Rf $CFG/i3
ln -sf $SRC/config/i3 $CFG/i3

# Link picom configuration
echo "-> Linking picom configuration"
[[ -f $CFG/picom ]] && rm -f $CFG/picom
[[ -d $CFG/picom ]] && rm -Rf $CFG/picom
ln -sf $SRC/config/picom $CFG/picom

# Link tmux configuration
echo "-> Linking tmux configuration"
[[ -f $CFG/tmux ]] && rm -f $CFG/tmux
[[ -d $CFG/tmux ]] && rm -Rf $CFG/tmux
ln -sf $SRC/config/tmux $CFG/tmux

# Link neovim configuration
echo "-> Linking neovim configuration"
[[ -f $CFG/nvim ]] && rm -f $CFG/nvim
[[ -d $CFG/nvim ]] && rm -Rf $CFG/nvim
ln -sf $SRC/config/nvim $CFG/nvim

# Install neovim plugins
echo "-> Installing neovim plugins"
NEOVIM=$LCL/share/nvim/site/pack/bezzz/start
mkdir -p $NEOVIM
if [[ -d $NEOVIM/catppuccin ]]; then
    read -p ":: A version of catppuccin theme is already installed, do you wish to update it? (*YES*/NO): " confirm
    if ! [[ $confirm == [nN] || $confirm == [nN][oO] ]]; then
        rm -rf $NEOVIM/catppuccin
        echo "-> Downloading catppuccin"
        git clone -q https://github.com/catppuccin/nvim.git $NEOVIM/catppuccin || echo "[ERROR] Failed to download catppuccin"
    else
        echo ":: Ok, ignoring catppuccin"
    fi
else
    echo "-> Downloading catppuccin"
    git clone -q https://github.com/catppuccin/nvim.git $NEOVIM/catppuccin || echo "[ERROR] Failed to download catppuccin"
fi
if [[ -d $NEOVIM/vim-cpp-modern ]]; then
    read -p ":: A version of vim-cpp-modern is already installed, do you wish to update it? (*YES*/NO): " confirm
    if ! [[ $confirm == [nN] || $confirm == [nN][oO] ]]; then
        rm -rf $NEOVIM/vim-cpp-modern
        echo "-> Downloading vim-cpp-modern"
        git clone -q https://github.com/bfrg/vim-cpp-modern.git $NEOVIM/vim-cpp-modern || echo "[ERROR] Failed to download vim-cpp-modern"
    else
        echo ":: Ok, ignoring vim-cpp-modern"
    fi
else
    echo "-> Downloading vim-cpp-modern"
    git clone -q https://github.com/bfrg/vim-cpp-modern.git $NEOVIM/vim-cpp-modern || echo "[ERROR] Failed to download vim-cpp-modern"
fi

# Post installation
echo ":: All set"
