#!/bin/bash

pushd ~/

bash .config/paperbash/uninstall.sh

curl -o install.sh "https://raw.githubusercontent.com/paperbenni/paperbash/master/setup.sh" >paperinstall.sh
source paperinstall.sh
rm paperinstall.sh

popd
