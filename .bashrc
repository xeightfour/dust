# Check if ran interactively
[[ $- != *i* ]] && return

if [[ -f ~/git-prompt.sh ]]; then
	source ~/git-prompt.sh
	PS1='[\[\e[92m\]\u@\h\[\e[0m\] \[\e[94;1m\]\W\[\e[0m\]]\[\e[93m\]$(GIT_PS1_SHOWUNTRACKEDFILES=1; GIT_PS1_SHOWDIRTYSTATE=1; __git_ps1 " (%s)")\[\e[0m\]❯ '
else
	echo '[WARNING] Did not find ~/git-prompt.sh'
	PS1='[\[\e[92m\]\u@\h\[\e[0m\] \[\e[94;1m\]\W\[\e[0m\]]❯ '
fi

alias l='ls --color=never'
alias ls='ls --color=auto'
alias la='ls --color=auto -A'
alias ll='ls --color=auto -ltrh'

alias grep='grep --color=auto'
alias diff='diff --color=auto'

alias xin='echo xin && sudo ~/scripts/setup.sh 1 && { sudo ~/scripts/parre.py & } && startx'
alias ply='mpv --no-vid --loop-playlist=inf'
alias lck='i3lock -i ~/.wallock -t'
alias stp='~/dust/scripts/setup.sh'

export GDK_SCALE=2
export GDK_DPI_SCALE=0.5

# Good old friends...
function ass {
	name=$(echo $1 | rev | cut -d '.' -f 2- | rev)
	if ! [[ -z $2 ]]; then
		g++ $1 -Wall -Wextra "$2" -std=c++20 -O2 -o "$name.out"
	else
		g++ $1 -Wall -Wextra -std=c++20 -O2 -o "$name.out"
	fi
}
function run {
	name=$(echo $1 | rev | cut -d '.' -f 2- | rev)
	./"$name.out"
}
function cnr {
	ass $1 && run $1
}
function gen {
	for name in $@; do
		ext=$(echo $name | rev | cut -d '.' -f 1 | rev)
		cp -f ~/codoin/gp/templates/"main.$ext" ./"$name"
	done
}

export -f ass
export -f run
export -f cnr
export -f gen

function call {
	echo $1 | sudo tee /proc/acpi/call > /dev/null && sudo cat /proc/acpi/call; echo
}
