#!/usr/bin/env bash

first=true
counter=0
pkill -f "turbostat.*PkgWatt"
turbostat -q --interval 5 --show PkgWatt --cpu "" -S | while read line; do
    if [ "$first" = true ] ; then
        first=false
    else
        LIMIT=$(intel-undervolt read | grep -oP 'Long term package power: \K(\d+)')
        CURR=$(echo "$line" | LC_ALL=C xargs printf "%.*f\n" 0)

        if (( CURR > 15 )); then
            (( counter++ ));
        else
            counter=0
        fi

        if (( LIMIT > 15 )); then
            BACKGROUND="#994444"
        else
            BACKGROUND=""
        fi

        if (( CURR > 15 && counter > 1 )); then
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

