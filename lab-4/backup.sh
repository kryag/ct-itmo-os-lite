#!/bin/bash

function file_size() {
    stat -c %s "$1"
}

backup_dir="$HOME/"
source_dir="$HOME/source/"
backup_report="$HOME/backup-report"

if [[ ! -d "$source_dir" ]]
then
    echo "Directory $source_dir not found."
    exit 1
fi

if [[ ! -f "$backup_report" ]]
then
    touch "$backup_report"
fi

current_date=$(date +"%Y-%m-%d")
active_backup_dir=$(find "$backup_dir" -maxdepth 1 -type d -name "Backup-*" -ctime -7 | tail -n 1)

if [[ -z "$active_backup_dir" ]]
then
    backup_dir="$backup_dir""Backup-$current_date"
    mkdir "$backup_dir"
    cp -r "$source_dir"* "$backup_dir"
    echo "Created $backup_dir ($current_date)" >> "$backup_report"
    for file in "$backup_dir"/*
    do
        basename "$file" >> "$backup_report"
    done
else
    backup_dir="$active_backup_dir"
    echo "Changed $backup_dir ($current_date)" >> "$backup_report"
    backup_dir="$backup_dir"/
    for file in "$source_dir"*
    do
        file=$(basename "$file")
        if [[ -f "$backup_dir$file" ]]
        then
            if [[ $(file_size "$source_dir$file") -ne $(file_size "$backup_dir$file") ]]
            then
                mv "$backup_dir$file" "$backup_dir$file.$current_date"
                cp "$source_dir$file" "$backup_dir$file"
                echo "$file $file.$current_date" >> "$backup_report"
            fi
        else
            cp "$source_dir$file" "$backup_dir$file"
            echo "$file" >> "$backup_report"
        fi
    done
fi

echo "Backup completed."
