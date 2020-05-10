#!/usr/bin/env bash

files=$(find /etc -regextype posix-extended -regex ".+\.pacnew" 2> /dev/null)

filesNum=$(echo -n "$files" | grep -c '^')

echo "Found $filesNum files"
echo "$files"

for file in $files
do
    file_my=${file%.*}
    echo ""
    read -p "Running nvim in diff mode for ${file_my} ${file}, press Enter..."
    sudo -E nvim -d $file_my $file
done
