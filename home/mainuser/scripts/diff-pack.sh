#!/usr/bin/env bash

# shows diffs for all files belonging to a given package

if [[ "$1" == "" ]];
then
    echo "Example usage: diff-pack pacman"
elif ! pacman -Q "$1" > /dev/null ;
then
    exit 1
else
    ver=$(pacman -Q "$1" | cut -f2 -d' ')
    pacman -Qii "$1" | grep ^MODIFIED | cut -f2 | while read file;
    do
        echo -e "\033[1;34m========================================================"
        echo $file
        echo -e "========================================================\033[0m"
        diff-pack-file.sh $file
        echo ""
    done
    exit 0
fi
