#!/bin/bash

output_file="report.log"
echo -n > "$output_file"

array=()
step=0

while true
do
    for ((i=1; i <= 10; i++))
    do
        array+=($i)
    done

    (( step++ ))

    if ((step % 100000 == 0))
    then
        size=${#array[@]}
        echo "Step: $step | Array size: $size" >> "$output_file"
    fi
done
