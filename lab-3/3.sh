#!/bin/bash

script="./1.sh"
echo "*/5 * * * 5 $script" | crontab
