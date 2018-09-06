#!/bin/bash

pushd ~
mkdir .config/paperbash || echo "config already existing, reinstalling..."
cd .config/paperbash

rm -rf *
git clone --depth=1 https://github.com/paperbenni/paperbash.git .
cd "functions"
chmod +x *.sh
cd ..

RAWGITHUB="https://raw.githubusercontent.com/paperbenni/paperbash/master"

functions/pkginstall.sh git wget

cd ~/

#add paperbash to .bashrc
if (grep 'source ~/.config/paperbash/paperbash.sh || echo paperbash corrupted' ~/.bashrc); then
	echo 'bashrc is already setup'
else
	echo 'source ~/.config/paperbash/paperbash.sh || echo paperbash corrupted' >>~/.bashrc
fi

#setup package diretory
mkdir .paperbash
mkdir .config/papersources || (echo "reinstalling sources" && rm -rf .config/papersources/*)
cd .config/papersources

if [ -e sources.txt ]; then
	echo "leaving existing sources"
else
	echo "paperbenni/bash" >>sources.txt
fi

mkdir sources
popd
