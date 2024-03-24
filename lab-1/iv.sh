#!/bin/bash

if [[ $HOME == $PWD ]]
then
    echo $HOME
else
    echo "Ошибка, скрипт запущен не из домашнего директория"
    exit 1
fi
