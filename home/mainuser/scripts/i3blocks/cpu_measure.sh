#!/usr/bin/env bash

first=true
counter=0
pkill -f "turbostat.*PkgWatt"
turbostat -q --interval 5 --show PkgWatt --cpu "" -S | while read line; do
    if [ "$first" = true ] ; then
        first=false
    else
        #LIMIT=$(intel-undervolt read | grep -oP 'Long term package power: \K(\d+)')
        LIMIT=$(echo "$(rdmsr 0x610 -f 14:0 -d)/2^$(rdmsr 0x606 -f 3:0 -d)" | bc -l | LC_ALL=C xargs printf "%.0f")
        CURR=$(echo "$line" | LC_ALL=C xargs printf "%.*f\n" 0)

        if (( CURR > 25 )); then
            (( counter++ ));
        else
            counter=0
        fi

        if (( LIMIT > 25 )); then
            BACKGROUND="#994444"
        else
            BACKGROUND=""
        fi

        if (( CURR > 25 && counter > 1 )); then
            FULLTEXT="⚡ ${CURR}W/${LIMIT}W 🔥"
        else
            FULLTEXT="⚡ ${CURR}W/${LIMIT}W"
        fi


        if [ -z $BACKGROUND ]; then
            stdbuf -oL printf "{\"full_text\": \"${FULLTEXT}\", \
                \n"
        else
            stdbuf -oL printf "{\"full_text\": \"${FULLTEXT}\", \
                \"background\": \"${BACKGROUND}\"} \
                \n"
        fi
    fi
done

