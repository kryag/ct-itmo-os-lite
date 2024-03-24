#!/bin/bash

output_file="duplicates.txt"

function error() {
    echo "$1"
    exit 1
}

if [[ $# -ne 1 ]]
then
    error "Expected 1 argument — directory path."
fi

work_dir="$1"
if [[ ! -d "$work_dir" ]]
then
    error "Directory '$work_dir' does not exist."
fi

duplicates=$(find "$work_dir" -type f -exec md5sum {} + | sort | uniq -w32 -d --all-repeated=separate | cut -d ' ' -f 3-)

if [[ -n "$duplicates" ]]
then
    echo "Duplicates:" > "$output_file"
    group=1
    while read -r line
    do
        if [[ -z "$line" ]]
        then
            echo "$group)$files" >> "$output_file"
            files=""
            (( group++ ))
        else
            files+=" $line"
        fi
    done <<< "$duplicates"
    echo "$group)$files" >> "$output_file"
else
    echo "No duplicates found." > "$output_file"
fi
