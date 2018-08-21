#!/bin/bash
if apk -v; then
	sudo apk update
	sudo apk install "$1"
fi
if apt -v; then
	if ! spkg -s "$1"; then
		sudo apt update
		sudo apt install -y "$1"
	fi
fi
