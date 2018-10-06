#!/bin/bash
pushd "$HOME"
echo "uninstalling $1"
bash .paperbenni/"$1"/remove.paperpackage
rm -rf .paperbenni/"$1"
rm paperbin/"$1"
rm paperstart/"$1"
echo "done uninstalling $1"