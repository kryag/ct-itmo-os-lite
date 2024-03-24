#!/bin/bash

file="iv_out"

function take_value() {
    cat $1 | awk -v search="$2" '$1 == search {print $NF}'
}

for pid in $(ps -axo pid --no-headers)
do
    status=/proc/$pid/status
    sched=/proc/$pid/sched
    if [[ -f $status ]] && [[ -f $sched ]]
    then
        ppid=$(take_value $status "PPid:")
        sum=$(take_value $sched "se.sum_exec_runtime")
        count=$(take_value $sched "nr_switches")
        art=$(echo $sum $count | awk '{print $1 / $2}')
        echo "ProcessID=$pid : Parent_ProcessID=$ppid : Average_Running_Time=$art"
    fi
done | sort -Vk2 > $file
