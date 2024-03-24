#!/bin/bash

backup_dir="$HOME/"
restore_dir="$HOME/restore/"

latest_backup=$(find "$backup_dir" -maxdepth 1 -type d -name "Backup-*" | sort | tail -n 1)
if [[ -z "$latest_backup" ]]
then
    echo "No backup exists."
    exit 1
fi

mkdir -p "$restore_dir"
for file in "$latest_backup"/*
do
    file=$(basename "$file")
    if ! echo "$file" | grep -q -E '.[0-9]{4}-[0-9]{2}-[0-9]{2}'
    then
        cp -r "$latest_backup/$file" "$restore_dir$file"
    fi
done

echo "Upback completed."
