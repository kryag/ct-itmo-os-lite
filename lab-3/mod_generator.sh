#!/bin/bash

fifo="pipe"

while true
do
    read line
    command=$(echo "$line" | awk '{print $1}')
    if [[ "$command" = "change" ]]
    then
        new_fifo=$(echo "$line" | awk '{print $2}')
        fifo="$new_fifo"
    else
        echo "$line" > $fifo
    fi
done
