#!/bin/bash

input_file="iv_out"
output_file="v_out"

./iv.sh

cur_ppid=""
total_art=0
count=0

function print_group() {
    if [[ "$count" -gt 0 ]]
    then
        average_art=$(echo $total_art $count | awk '{print $1 / $2}')
        echo "Average_Running_Children_of_ParentID=$cur_ppid is $average_art" >> $output_file
    fi
}

if [[ -f ./$output_file ]]
then
    rm $output_file
fi
touch $output_file

while read line
do
    ppid=$(echo $line | cut -d '=' -f 3 | awk '{print $1}')
    art=$(echo $line | cut -d '=' -f 4 | awk '{print $1}')
    if [[ -z $cur_ppid ]]
    then
        cur_ppid="$ppid"
    fi
    if [[ "$ppid" -eq "$cur_ppid" ]]
    then
        total_art=$(echo $total_art $art | awk '{print $1 + $2}')
        count=$(($count + 1))
    else
        print_group
        cur_ppid="$ppid"
        total_art="$art"
        count=1
    fi
    echo $line >> $output_file
done < $input_file
print_group
