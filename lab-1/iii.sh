#!/bin/bash

PS3="Введите нужную операцию: "
select op in nano vi links quit;
do
    case $op in
        nano) nano ;;
        vi) vi ;;
        links) links ;;
        quit) break ;;
        *) echo "Некорректная операция - $REPLY" ;;
    esac
done
