# Check if ran interactively
[[ $- != *i* ]] && return

if [[ ":$PATH:" != *":$HOME/scripts:"* ]]; then
	export PATH="$HOME/scripts:$PATH"
fi

export EDITOR=vim
export VISUAL=vim
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export GTK_THEME="Skeuos-Blue-Dark"
export ICON_THEME="Flat-Remix-Yellow-Dark"
export FONT_NAME="IBM Plex Sans 11"
export QT_QPA_PLATFORMTHEME="gtk3"

# Wayland
export XDG_SESSION_TYPE=wayland
export CLUTTER_BACKEND=wayland
export SDL_VIDEODRIVER=wayland

# Bash history
export HISTCONTROL="ignoredups:erasedups"
export HISTSIZE=5000
export HISTFILESIZE=10000
shopt -s histappend

gitPrompt="/usr/share/git/completion/git-prompt.sh"
if [[ -r "$gitPrompt" ]]; then
	source "$gitPrompt"
	PS1='[\[\e[32m\]\u@\h\[\e[0m\] \[\e[34;1m\]\W\[\e[0m\]]'
	PS1+='\[\e[33m\]$(GIT_PS1_SHOWUNTRACKEDFILES=1; '
	PS1+='GIT_PS1_SHOWDIRTYSTATE=1; __git_ps1 " (%s)")\[\e[0m\]\$ '
else
	PS1='[\[\e[32m\]\u@\h\[\e[0m\] \[\e[34;1m\]\W\[\e[0m\]]\$ '
fi

# Aliases
alias l="ls --color=never"
alias ls="ls --color=auto"
alias la="ls --color=auto -A"
alias ll="ls --color=auto -ltrh"
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias lck="i3lock -i ~/assets/lockscreen.png -tk"

bounce() {
	echo -e "$1 \e[31m):\e[0m"
}

# Start the Wayland session
xin() {
	if (( $EUID == 0 )); then
		bounce "Oh no, we don't have permission"
		return 1
	fi
	echo "Launching Wayland session..."
	cd ~ && exec sway
}

hibernate() {
	sudo echo "Taking a nap, see you soon!"
	lck && sleep 1
	sudo systemctl hibernate
}

# Good old friends
ass() {
	local name="${1%.*}"
	if [[ -n "$2" ]]; then
		g++ "$1" -Wall -Wextra "$2" -std=c++17 -O2 -o "${name}.out"
	else
		g++ "$1" -Wall -Wextra -std=c++17 -O2 -o "${name}.out"
	fi
	if [[ $? -ne 0 ]]; then
		bounce "Oops, guess something needs fixing"
		return 1
	fi
}

run() {
	local name="${1%.*}"
	if [[ ! -f "${name}.out" ]]; then
		bounce "Oops, ${name}.out isn't here"
		return 1
	fi
	./"${name}.out"
}

cnr() {
	ass "$1" && run "$1"
}

gen() {
	for name in "$@"; do
		local ext="${name##*.}"
		cp -f ~/codoin/gp/templates/"main.$ext" "./$name"
		if [[ $? -ne 0 ]]; then
			bounce "Whoops, couldn't grab the template for $name"
		fi
	done
}

export -f ass
export -f run
export -f cnr
export -f gen

call() {
	echo "$1" | sudo tee /proc/acpi/call > /dev/null
	if [[ $? -ne 0 ]]; then
		bounce "Nope, /proc/acpi/call said no"
		return 1
	fi
	sudo cat /proc/acpi/call
	if [[ $? -ne 0 ]]; then
		bounce "Nope, /proc/acpi/call said no"
		return 1
	fi
	echo
}
