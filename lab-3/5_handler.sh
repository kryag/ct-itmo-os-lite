#!/bin/bash

generator_pid="$1"
fifo="$2"

operation="+"
result=1

(tail -f $fifo) | while true
do
    read command

    case "$command" in
        "+") operation="+";;
        "*") operation="*";;
        "QUIT")
            echo "Ok, quit. Final result: $result"
            rm $fifo
            killall tail
            kill $generator_pid
            exit
            ;;
        *)
            if [[ $command =~ ^[0-9]+$ ]]
            then
                if [[ $operation == "+" ]]
                then
                    let result=result+$command
                else
                    let result=result*$command
                fi
            else
                echo "Bad command, forced exit"
                rm $fifo
                killall tail
                kill $generator_pid
                exit 1
            fi
            ;;
    esac
done
