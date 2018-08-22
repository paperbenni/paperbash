#!/bin/bash
if [ ! -n "$1" ]; then
	echo "usage: pb debug [ on or off ]"
	exit
fi
if [ "$1" = "on" ] || [ "$1" = "enable" ]; then
	echo "true" >~/.config/paperbash/.paperdebug
	echo "debugging mode for paperbash enabled"
else

	if [ -e ~/.config/paperbash/.paperdebug ]; then
		rm ~/.config/paperbash/.paperdebug
		echo "debugging mode for paperbash disabled"
	else
		echo "debugging mode already disabled"
	fi
fi
