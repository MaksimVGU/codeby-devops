#!/bin/bash

folder="$HOME/myfolder"

mkdir -p "$folder"

printf 'Привет!\n%s\n' "$(date '+%d.%m.%Y %H:%M:%S')" > "$folder/1"

if [ ! -f "$folder/2" ]; then
    touch "$folder/2"
fi
chmod 777 "$folder/2"

if [ ! -f "$folder/3" ]; then
    tr -dc '[:alnum:]' < /dev/urandom | head -c 20 > "$folder/3"
    printf '\n' >> "$folder/3"
fi

touch "$folder/4" "$folder/5"
