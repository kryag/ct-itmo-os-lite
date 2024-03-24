#!/bin/bash

fifo="pipe"
mkfifo $fifo

./5_handler.sh "$$" "$fifo" &

while true
do
    read command
    echo "$command" > $fifo
done
