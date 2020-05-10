#!/usr/bin/env bash

first=true
counter=0
pkill -f "turbostat.*PkgTmp"
turbostat -q --interval 5 --show PkgTmp --cpu "" -S | while read line; do
    if [ "$first" = true ] ; then
        first=false
    else
        if (( line > 70 )); then
            (( counter++ ));
        else
            counter=0
        fi

        RESULT="🌡️"
        RESULT+=" ${line}°C"
        [[ $line > 70 && $counter > 1 ]] && RESULT+=" 🔥"
        [[ $line > 70 ]] && RESULT="<span foreground=\"#F06655\" \
            font_weight=\"bold\">${RESULT}</span>"

        echo "$RESULT"
    fi
done
