#!/bin/bash

folder="$HOME/myfolder"

mkdir -p "$folder"

find "$folder" -maxdepth 1 -type f | wc -l

if [ -f "$folder/2" ]; then
    chmod 664 "$folder/2"
fi

for file in "$folder"/*; do
    if [ -f "$file" ] && [ "$file" != "$folder/2" ] && [ ! -s "$file" ]; then
        rm -f "$file"
    fi
done

for file in "$folder"/*; do
    if [ -f "$file" ]; then
        sed -i '1!d' "$file"
    fi
done
