#!/usr/bin/env bash

FREE=$(free -m | grep -oP '^Mem: +\d+ +\K\d+')
TOTAL=$(free -m | grep -oP '^Mem: + \K\d+')
FREEINGB=$(echo $FREE/1024 | bc -l)
TOTALINGB=$(echo $TOTAL/1024 | bc -l)

LC_ALL=C printf "🐏 %.*fGB/%.*fGB\n" 1 "$FREEINGB" 1 "$TOTALINGB"
