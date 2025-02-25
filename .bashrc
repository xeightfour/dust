#!/bin/bash

# Check if ran interactively
[[ $- != *i* ]] && return

# Add custom scripts directory to PATH
if [[ ":$PATH:" != *":$HOME/scripts:"* ]]; then
	export PATH="$HOME/scripts:$PATH"
fi

# Set default editor
export EDITOR=nvim
export VISUAL=nvim

# Set XDG environment variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# Set GTK and Qt themes
export GTK_THEME='Skeuos-Blue-Dark'
export ICON_THEME='elementary'
export FONT_NAME='Noto Sans 12'
export QT_QPA_PLATFORMTHEME='gtk3'

# Set history control and size
export HISTCONTROL='ignoredups:erasedups'
export HISTSIZE=4000
export HISTFILESIZE=10000
shopt -s histappend

# Source git-prompt.sh if available
if [[ -f ~/git-prompt.sh ]]; then
	source ~/git-prompt.sh
	PS1='[\[\e[92m\]\u@\h\[\e[0m\] \[\e[94;1m\]\W\[\e[0m\]]\[\e[93m\]$(GIT_PS1_SHOWUNTRACKEDFILES=1; GIT_PS1_SHOWDIRTYSTATE=1; __git_ps1 " (%s)")\[\e[0m\]❯ '
else
	echo '[WARNING] Did not find ~/git-prompt.sh'
	PS1='[\[\e[92m\]\u@\h\[\e[0m\] \[\e[94;1m\]\W\[\e[0m\]]❯ '
fi

# Aliases
alias l='ls --color=never'
alias ls='ls --color=auto'
alias la='ls --color=auto -A'
alias ll='ls --color=auto -ltrh'

alias grep='grep --color=auto'
alias diff='diff --color=auto'

alias ply='mpv --no-vid --loop-playlist=inf'
alias stp='setup'
alias lck='i3lock -i ~/assets/lockscreen.png -tk'
alias tch='touchpad'

# Functions
function xin {
	if (( $EUID == 0 )); then
		echo 'Why are you root?'
		return 1
	fi
	echo 'Starting X session...'
	cd ~ && startx
}

function hibernate {
	echo 'Hibernating...'
	lck
	sudo systemctl hibernate
}

function ass {
	local name="${1%.*}"
	if [[ -n $2 ]]; then
		g++ "$1" -Wall -Wextra "$2" -std=c++20 -O2 -o "${name}.out"
	else
		g++ "$1" -Wall -Wextra -std=c++20 -O2 -o "${name}.out"
	fi
	if [[ $? -ne 0 ]]; then
		echo "Compilation failed."
		return 1
	fi
}

function run {
	local name="${1%.*}"
	if [[ ! -f "${name}.out" ]]; then
		echo "Executable '${name}.out' not found."
		return 1
	fi
	./"${name}.out"
}

function cnr {
	ass "$1" && run "$1"
}

function gen {
	for name in "$@"; do
		local ext="${name##*.}"
		cp -f ~/codoin/gp/templates/"main.$ext" "./$name"
		if [[ $? -ne 0 ]]; then
			echo "Failed to copy template for $name"
		fi
	done
}

# Export functions
export -f ass
export -f run
export -f cnr
export -f gen

function call {
	echo "$1" | sudo tee /proc/acpi/call > /dev/null
	if [[ $? -ne 0 ]]; then
		echo 'Failed to write to /proc/acpi/call'
		return 1
	fi
	sudo cat /proc/acpi/call
	if [[ $? -ne 0 ]]; then
		echo 'Failed to read from /proc/acpi/call'
		return 1
	fi
	echo
}
