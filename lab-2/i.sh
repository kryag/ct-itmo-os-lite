#!/bin/bash

file="i_out"
processes=$(ps -u $USER o pid,cmd --no-headers)
echo "$processes" | wc -l > $file
echo "$processes" | awk -v OFS=':' '{print $1, $2}' >> $file
