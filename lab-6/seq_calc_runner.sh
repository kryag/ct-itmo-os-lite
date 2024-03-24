#!/bin/bash

run_name="sine_calculating"

for ((x = 1; x <= $1; x++))
do
    ./$run_name $x
done
