#!/usr/bin/env bash

RESULT=$(df -h -P -l / | awk '/\/.*/ { print $3 "/" $2, "(" $5 ")" }')

echo 💾 $RESULT
#💽
