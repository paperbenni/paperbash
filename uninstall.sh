#!/bin/bash

pushd ~/

if curl "https://gist.githubusercontent.com/marioBonales/1637696/raw/337f7b60d4e3d9e887a0206dec6a737e94cdd26e/.bashrc" >.paperbashrc; then
	echo "beginning bashrc reset"
else
	echo "download failed"
	exit
fi


for PACKAGE in .paperbash/*/*; do
	if [ -e "$PACKAGE/remove.paperpackage" ]; then
		bash "$PACKAGE/remove.paperpackage"
	fi
done

rm -rf .config/paperbash
rm -rf .config/papersources
rm -rf .paperbash
rm -rf paperbin
rm -rf paperstart


popd