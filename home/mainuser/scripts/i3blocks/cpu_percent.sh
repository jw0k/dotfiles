#!/usr/bin/env bash

CPU_PERCENT=$(mpstat 1 1 | awk '/^Average/ {printf " %.0f", 100-$NF}')

RESULT="🏋"
RESULT+="🏻‍♂"
RESULT+="${CPU_PERCENT}%"

if (( CPU_PERCENT > 80 )); then
    RESULT="<b>${RESULT}</b>"
fi

echo $RESULT
echo $RESULT

if (( CPU_PERCENT > 80 )); then
    echo "#F06655"
fi
