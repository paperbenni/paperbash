#!/bin/bash
pushd ~/
if curl "https://gist.githubusercontent.com/marioBonales/1637696/raw/337f7b60d4e3d9e887a0206dec6a737e94cdd26e/.bashrc" >.paperbashrc; then
	echo "beginning reset"
else
	echo "download failed"
	exit
fi

for PACKAGE in .paperbash/*/*
do
	if [ -e "$PACKAGE/.paperdisable" ]
		bash "$PACKAGE/.paperdisable"
	fi
done
rm -rf .config/paperbash
rm -rf .config/papersources
rm -rf .paperbash
rm .bashrc
mv .paperbashrc .bashrc

curl -o install.sh "https://raw.githubusercontent.com/paperbenni/paperbash/master/install.sh" > paperinstall.sh; source paperinstall.sh; rm paperinstall.sh
popd
