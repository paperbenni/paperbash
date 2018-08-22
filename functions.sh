#!/bin/bash

PAPERBASHDIR="$HOME/.config/paperbash"
PAPERGITHUB="https://raw.githubusercontent.com/paperbenni/paperbash/master"
RAWGITHUB="https://raw.githubusercontent.com"
EDITOR=nvim

function pb() {
	if [ ! -n "$1" ]
	then
		bash "~/.config/paperbash/functions/help.sh"
		exit
	fi
	if [ -e "~/.config/paperbash/functions/$1.sh" ]
	then
		bash ./"$1.sh"
	else
		echo "command not found
		searching github"
		curl -o "$PAPERBASHDIR/functions/$1.sh" "$PAPERGITHUB/functions/$1.sh"
		if ! grep '/bin/bash' "$PAPERBASHDIR/functions/$1.sh"
		then
			rm "$PAPERBASHDIR/functions/$1.sh"
		else
			chmod +x "$PAPERBASHDIR/functions/$1"
			$PAPERBASHDIR/functions/"$1".sh
		fi

	fi

}
