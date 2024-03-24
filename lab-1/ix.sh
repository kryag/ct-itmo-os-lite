#!/bin/bash

wc -l /var/log/*.log | awk 'END {print $1}'
