#!/usr/bin/env bash

first=true
turbostat -q --interval 5 --show Bzy_MHz --cpu "" -S | while read line; do
    if [ "$first" = true ] ; then
        first=false
    else
        GHZ=$(echo "$line/1000" | bc -l)
        LC_ALL=C printf "%.*fGHz\n" 1 "$GHZ"
    fi
done

