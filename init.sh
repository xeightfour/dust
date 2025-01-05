#!/bin/bash

dust=$(cd -- $(dirname -- "${BASH_SOURCE[0]}") &> /dev/null && pwd)

function bounce {
	echo '[ERROR] donno what happened >:' && exit 1
}

if ! [[ -f ~/git-prompt.sh ]]; then
	echo 'Receiving git-prompt.sh...'
	curl -so ~/git-prompt.sh 'https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh' || bounce
fi

echo $dust > $dust/.dust
echo 'All done <:'
