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

export GTK_THEME='Skeuos-Blue-Dark'
export ICON_THEME='Flat-Remix-Yellow-Dark'
export FONT_NAME='IBM Plex Sans 13'
export QT_QPA_PLATFORMTHEME='gtk3'

# Wayland
export XDG_SESSION_TYPE='wayland'
export CLUTTER_BACKEND='wayland'
export SDL_VIDEODRIVER='wayland'

# Bash History
export HISTCONTROL='ignoredups:erasedups'
export HISTSIZE=6500
export HISTFILESIZE=10000
shopt -s histappend

shopt -s checkwinsize # lonely

# Source 'git-prompt.sh' for Git completions :\
gitPrompt='/usr/share/git/completion/git-prompt.sh'
if [[ -r "$gitPrompt" ]]; then
	source "$gitPrompt"
	PS1='[\[\e[32m\]\u@\h\[\e[0m\] \[\e[34;1m\]\W\[\e[0m\]]'
	PS1+='\[\e[33m\]$(GIT_PS1_SHOWUNTRACKEDFILES=1; '
	PS1+='GIT_PS1_SHOWDIRTYSTATE=1; __git_ps1 " (%s)")\[\e[0m\]\$ '
else
	PS1='[\[\e[32m\]\u@\h\[\e[0m\] \[\e[34;1m\]\W\[\e[0m\]]\$ '
fi

# Bash Aliases
alias l='ls --color=never'
alias ls='ls --color=auto'
alias la='ls --color=auto -A'
alias ll='ls --color=auto -ltrh'

alias grep='grep --color=auto'
alias diff='diff --color=auto'

alias lck='swaylock -f -i ~/assets/lockscreen.jpeg'

bounce() {
	local msg=(
		'Error 418: I’m a teapot, not a web server.'
		'Your computer has encountered an existential crisis. Reboot to confirm reality.'
		'Keyboard not detected. Press any key to continue... Wait, what?'
		'Congratulations! You’ve found the 7th hidden error of the day. Prize: Nothing.'
		'Out of memory. We recommend deleting your browser history for dignity’s sake.'
		'The program has performed an illegal operation and ill now be arrested.'
		'Your password is incorrect. Please blame your fingers and try again.'
		'System overload. Too many tabs open. Please close some and mourn lost productivity.'
		'This operation requires more RAM. Would you like to sacrifice a goat instead?'
		'Connection timed out. The internet is judging your Wi-Fi choices.'
	)
	local idx=$((RANDOM % ${#msg[@]}))
	echo -e "\e[31m${msg[$idx]}\e[0m"
}

# Start Wayland session
xin() { # shouldn't it be `win` from now on?!
	if (( $EUID == 0 )); then
		bounce && return 1
	fi
	echo 'Launching Wayland session...'
	cd ~ && exec sway
}

hibernate() {
	sudo echo 'Taking a nap, see you soon C:'
	lck && sleep 1
	sudo systemctl hibernate
}

ass() {
	local name="${1%.*}"
	if [[ -n "$2" ]]; then
		g++ "$1" -Wall -Wextra "$2" -std=c++17 -O2 -o "${name}.out"
	else
		g++ "$1" -Wall -Wextra -std=c++17 -O2 -o "${name}.out"
	fi
	if [[ $? -ne 0 ]]; then
		bounce && return 1
	fi
}

run() {
	local name="${1%.*}"
	if [[ ! -f "${name}.out" ]]; then
		bounce && return 1
	fi
	./"${name}.out"
}

cnr() {
	ass "$1" && run "$1"
}

gen() {
	for name in "$@"; do
		local ext="${name##*.}"
		cp -f ~/codoin/gp/templates/"main.$ext" ./"$name"
		if [[ $? -ne 0 ]]; then
			bounce
		fi
	done
}

call() {
	echo "$1" | sudo tee /proc/acpi/call > /dev/null
	if [[ $? -ne 0 ]]; then
		bounce && return 1
	fi
	sudo cat /proc/acpi/call
	if [[ $? -ne 0 ]]; then
		bounce && return 1
	fi
	echo
}
