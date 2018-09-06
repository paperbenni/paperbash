#!/bin/bash

if ! [ -n "$1" ]; then
	echo "no packages specified"
	exit
fi

if apk -v; then
	sudo apk update
	sudo apk install "$@"
fi

if apt-get -v; then
	for package in "$@"; do
		if ! dpkg -s "$package"; then
			sudo apt update
			sudo apt install -y "$package"
		else
			echo "$package already installed"
		fi
	done

fi
