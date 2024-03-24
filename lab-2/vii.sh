#!/bin/bash

declare -A bytes

function get_data() {
    for pid in $(ps axo pid --no-headers)
    do
        file=/proc/$pid/io
        if [[ -f $file ]]
        then
            bytes_read=$(cat $file | awk '$1 == "read_bytes:" {print $2}')
            if [[ -v bytes["$pid"] ]]
            then
                bytes["$pid"]=$(echo bytes["$pid"] $bytes_read | awk '{print $1 + $2}')
            else
                bytes["$pid"]=$(echo bytes["$pid"] | awk '{print -1 * $1}')
            fi
        fi
    done
}

get_data
sleep 60
get_data

for key in "${!bytes[@]}"
do
    echo "$key $(ps -o command -p $key --no-headers) ${bytes[$key]}"
done | sort -n -k3 -r | head -n 3 | awk -v OFS=':' '{print $1, $2, $3}'
