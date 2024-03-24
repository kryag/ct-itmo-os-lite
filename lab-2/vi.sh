#!/bin/bash

mx_pid=0
mx_size=0

for pid in $(ps axo pid --no-headers)
do
    file=/proc/$pid/status
    if [[ -f $file ]]
    then
        size=$(cat $file | awk '$1 == "VmSize:" {print $2}')
        if [[ $size -gt $mx_size ]]
        then
            mx_pid=$pid
            mx_size=$size
        fi
    fi
done

if [[ $mx_size -eq 0 ]]
then
    echo "No processes"
else
    echo $mx_pid
fi
