#!/bin/bash

N=$1
K=$2

counter=1
while [[ $counter -le $K ]]
do
    ./newmem.bash $N &
    (( counter++ ))
    sleep 1
done
