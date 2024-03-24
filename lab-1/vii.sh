#!/bin/bash

grep -E -r -o -s -h '[[:alnum:]+.\_-]*@[[:alnum:]+.\_-]*' /etc | awk '{printf("%s, ", $0)}' | sed 's/, $//' > emails.lst
