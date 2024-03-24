#!/bin/bash

run_name="file_changing"

for ((no = 1; no <= $1; no++))
do
    ./$run_name $no
done
