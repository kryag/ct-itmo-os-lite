#!/bin/bash

function error() {
    echo "$1"
    exit 1
}

if [[ $# -ne 1 ]]
then
    error "Expected 1 argument - file name."
fi

rm_file=$1
if [[ ! -f "$rm_file" ]]
then
    error "File '$rm_file' does not exist."
fi

trash_dir="$HOME/.trash/"
mkdir -p "$trash_dir"

count=1
link_file="$rm_file"
while [[ -f "$trash_dir$link_file" ]]
do
    (( count++ ))
    link_file="$rm_file$count"
done

ln "$rm_file" "$trash_dir$link_file"
rm -f "$rm_file"

log_file="$HOME/.trash.log"
if [[ ! -f "$log_file" ]]
then
    touch "$log_file"
fi

echo "$(realpath "$rm_file") : $link_file" >> "$log_file"
echo "'$rm_file' was successfully removed."
