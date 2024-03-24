#!/bin/bash

script1="./infinite_loop_1.sh"
script2="./infinite_loop_2.sh"
script3="./infinite_loop_3.sh"

$script1 &
pid1=$!
$script2 &
$script3 &
pid3=$!

cpulimit -p $pid1 -l 10
kill $pid3
