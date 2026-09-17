#!/bin/bash

BACKUP_DIR="/opt/mysql_backup"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/lesson9_$DATE.sql"

mkdir -p "$BACKUP_DIR"

mariadb-dump --single-transaction --routines --triggers --databases lesson9 > "$BACKUP_FILE"

if [ $? -eq 0 ]; then
    gzip "$BACKUP_FILE"
    rsync -avz "$BACKUP_DIR/" rsync://192.168.122.27/mysql/
    find "$BACKUP_DIR" -type f -name "*.gz" -mtime +7 -delete
else
    rm -f "$BACKUP_FILE"
    exit 1
fi
