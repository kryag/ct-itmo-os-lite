#!/bin/bash

function error() {
    echo "$1"
    exit 1
}

if [[ $# -ne 1 ]]
then
    error "Expected 1 argument - file name."
fi

log_file="$HOME/.trash.log"
if [[ ! -f "$log_file" ]]
then
    error "File '$log_file' does not exist."
fi

trash_dir="$HOME/.trash/"
if [[ ! -d "$trash_dir" ]]
then
    error "Directory '$trash_dir' does not exist."
fi

restore_file=$1
matches=$(grep "/$restore_file : " "$log_file")

if [[ -z "$matches" ]]
then
    error "File '$restore_file' not found."
fi

while read -r line
do
    link_file=$(echo "$line" | awk -F' : ' '{print $2}')
    echo -n "Do you want to restore the '$link_file'? (y/n): "
    read -r answer </dev/tty
    if [[ "$answer" == "y" ]]
    then
        restore_dir=$(dirname "$(echo "$line" | awk -F' : ' '{print $1}')")
        if [[ ! -d "$restore_dir" ]]
        then
            echo "Directory '$restore_dir' does not exist. Restore to '$HOME' directory."
            restore_dir="$HOME/"
        fi
        while true
        do
            if ln "$trash_dir/$link_file" "$restore_dir/$restore_file" 2>/dev/null
            then
                rm -f "$trash_dir/$link_file"
                sed -i "/: $link_file\$/d" "$log_file"
                echo "File '$restore_file' was successfully restored to the directory '$restore_dir'."
                break
            else
                echo -n "File cannot be restored. Enter a new file name: "
                read -r new_file_name </dev/tty
                restore_file="$new_file_name"
            fi
        done
    fi
done <<< "$matches"

echo "File recovery is complete."
