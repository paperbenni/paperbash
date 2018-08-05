#!/bin/bash
pushd ~/.paperbenni

for FILE in $(find . -name '*.sh')
do
[ -e $FILE ] || continue
source $FILE
done

popd

popd