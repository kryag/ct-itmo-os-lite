#!/bin/bash

script="./1.sh"
echo 'bash $script' | at now + 2 minutes
tail -f ~/report
