#!/bin/bash

runner="parallel_mem_runner.sh"
compile_name="file_changing"
g++ "$compile_name.cpp" -o $compile_name

log_file="parallel_mem.log"
if [[ ! -f $log_file ]]
then
    touch $log_file
else
    echo -n > $log_file
fi

MAX_N=20
runs=10

for ((N = 1; N <= $MAX_N; N++))
do
    echo "$N:" >> $log_file
    for ((i = 1; i <= $runs; i++))
    do
        \time -f "%E" "./$runner" $N > /dev/null 2>>$log_file
    done
done
