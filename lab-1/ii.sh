#!/bin/bash

while read str && [ "$str" != "q" ]
do
    res="$res$str"
done
echo $res
