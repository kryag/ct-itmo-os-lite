#!/bin/bash

fifo="$1"
echo $$ > $fifo

result=1

trap 'let result=result+2; echo $result' USR1
trap 'let result=result*2; echo $result' USR2
trap 'exit' SIGTERM

while true
do
    sleep 1
done
