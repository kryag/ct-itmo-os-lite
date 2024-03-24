#!/bin/bash

ps axo pid,etime --sort=etime --no-headers | awk 'NR == 1 {print $1}'
