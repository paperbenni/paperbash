#!/bin/bash
pushd ~/
echo "sucessfully installed paperbash"
curl https://raw.githubusercontent.com/paperbenni/paperbash/master/setup.sh >>~/.bashrc
mkdir .paperbash
mkdir .config/paperbash
cd .config/paperbash
curl https://raw.githubusercontent.com/paperbenni/paperbash/master/version.txt >version.txt
curl https://raw.githubusercontent.com/paperbenni/paperbash/master/functions.sh >functions.sh
if [ -e sources.txt ]; then
	echo "leaving existing sources"
else
	echo "paperbenni/bash" >>sources.txt
fi
mkdir sources
popd
