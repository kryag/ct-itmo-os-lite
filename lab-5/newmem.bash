#!/bin/bash

N=$1
array=()
size=0

while [[ $size -le $N ]]
do
    for ((i=1; i <= 10; i++))
    do
        array+=($i)
    done
    let size=$size+10
done
