#!/bin/bash

ps axl -u $USER | grep defunct | awk '{system ("kill -9 " $4)}'
