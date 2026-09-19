#!/bin/bash

# Рабочая директория
readonly FOLDER="$HOME/myfolder"

# Файлы
readonly FILE_ONE="$FOLDER/1"
readonly FILE_TWO="$FOLDER/2"
readonly FILE_THREE="$FOLDER/3"
readonly FILE_FOUR="$FOLDER/4"
readonly FILE_FIVE="$FOLDER/5"

# Права доступа
readonly INITIAL_PERMISSIONS="777"

create_folder() {
    mkdir -p "$FOLDER"
}

create_file_one() {
    printf 'Привет!\n%s\n' "$(date '+%d.%m.%Y %H:%M:%S')" > "$FILE_ONE"
}

create_file_two() {
    if [ ! -f "$FILE_TWO" ]; then
        touch "$FILE_TWO" || return 1
    fi

    chmod "$INITIAL_PERMISSIONS" "$FILE_TWO"
}

create_file_three() {
    if [ ! -f "$FILE_THREE" ]; then
        tr -dc '[:alnum:]' < /dev/urandom | head -c 20 > "$FILE_THREE" || return 1
        printf '\n' >> "$FILE_THREE" || return 1
    fi
}

create_empty_files() {
    touch "$FILE_FOUR" "$FILE_FIVE"
}

main() {
    create_folder || return 1
    create_file_one || return 1
    create_file_two || return 1
    create_file_three || return 1
    create_empty_files || return 1
}

main
