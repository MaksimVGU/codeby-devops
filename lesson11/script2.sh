#!/bin/bash

# Рабочая директория
readonly FOLDER="$HOME/myfolder"

# Файл, для которого меняются права
readonly FILE_TWO="$FOLDER/2"

# Новые права доступа
readonly FINAL_PERMISSIONS="664"

create_folder() {
    mkdir -p "$FOLDER"
}

count_files() {
    find "$FOLDER" -maxdepth 1 -type f | wc -l
}

change_file_permissions() {
    if [ -f "$FILE_TWO" ]; then
        chmod "$FINAL_PERMISSIONS" "$FILE_TWO" || return 1
    fi
}

delete_empty_files() {
    for file in "$FOLDER"/*; do
        if [ -f "$file" ] && [ "$file" != "$FILE_TWO" ] && [ ! -s "$file" ]; then
            rm -f "$file" || return 1
        fi
    done
}

leave_first_line() {
    for file in "$FOLDER"/*; do
        if [ -f "$file" ]; then
            sed -i '1!d' "$file" || return 1
        fi
    done
}

main() {
    create_folder || return 1
    count_files
    change_file_permissions || return 1
    delete_empty_files || return 1
    leave_first_line || return 1
}

main
