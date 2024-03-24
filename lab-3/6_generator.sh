#!/bin/bash

fifo="pipe"
mkfifo $fifo

./6_handler.sh "$fifo" &

pid=$(cat $fifo)

while true
do
    read command

    case $command in
        "+") kill -USR1 $pid;;
        "*") kill -USR2 $pid;;
        TERM)
            kill -SIGTERM $pid
            rm $fifo
            exit
            ;;
    esac
done
