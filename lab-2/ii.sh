#!/bin/bash

file="ii_out"
ps ax | grep '/sbin/' | awk '{print $1}' > $file
