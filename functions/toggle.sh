#!/bin/bash

#iterate through paperbash package folders

for DIR in ~/.paperbash/*/*; do
	if [ "$DIR" = "$1" ]; then
		if [ -e "$DIR/.paperdisabled" ]; then
			while IFS= read -r -d '' file; do
				mv "$file" "$file.papertoggled"
			done < <(find "$DIR" -mtime -7 -name '*.sh' -print0)
			rm "$DIR/.paperdisabled"
			if [ -e "$DIR/.paperenable" ]; then
				bash "$DIR/.paperenable"
			fi
		else
			while IFS= read -r -d '' file; do
				mv "$file" "${file%.papertoggled}"
			done < <(find "$DIR" -mtime -7 -name '*.papertoggled' -print0)
			if [ -e "$DIR/.paperdisable" ]; then
				bash "$DIR/.paperdisable"
			fi
		fi
	fi
done

echo "disabled $1 please restart bash for the changes to apply"
