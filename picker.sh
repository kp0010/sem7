#!/usr/bin/env bash

dir=~/Dev/temp/sem7/

selected=$(
    (cd "$dir" && fd -t f -e pdf -e md .) | fzf
)

if [[ -z $selected ]]; then
    exit 0
fi

fullpath="$dir/$selected"
extension="${selected##*.}"

if [[ "$1" == "-b" ]]; then
    blobdrop $fullpath
else
    if [[ "$extension" = "pdf" ]]; then
	app=$(
	    (
	    echo -e "zathura\nzen"
	    ) | fzf
	)
	if [[ -z $app ]]; then
	    zen-browser $fullpath
	elif [[ "$app" = "zathura" ]]; then
	    zathura $fullpath
	else
	    zen-browser $fullpath
	fi
    elif [[ "$extension" = "md" ]]; then
	nvim $fullpath
    else
	zen-browser $fullpath
    fi
fi
