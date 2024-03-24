#!/bin/bash

man bash | grep -o '\w\{4,\}' | sort | uniq -c | sort -n -r | head -3
