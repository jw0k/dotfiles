#!/usr/bin/env bash

speed=0
tries=0
function changeSpeed() { # param: newSpeed
    newSpeed="$1"
    if (( newSpeed != speed )); then
        (( tries++ ))
        if (( tries == 2 )); then
            tries=0
            speed=$newSpeed
        fi
    else
        tries=0
    fi
}

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

        if (( line < 40 )); then
            changeSpeed 0
        elif (( line >= 40 && line < 50 )); then
            changeSpeed 1
        elif (( line >= 50 && line < 60 )); then
            changeSpeed 32
        elif (( line >= 60 && line < 70 )); then
            changeSpeed 50
        elif (( line >= 70 && line < 80 )); then
            changeSpeed 80
        elif (( line >= 80 )); then
            changeSpeed 100
        fi

        speedPadded=`printf %03d $speed`

        [ -c /dev/fan_controller_ch340 ] && echo -ne "s${speedPadded}" > /dev/fan_controller_ch340

        RESULT="🌡️"
        RESULT+=" ${line}°C"
        [[ $line > 70 && $counter > 1 ]] && RESULT+=" 🔥"
        [[ $line > 70 ]] && RESULT="<span foreground=\"#F06655\" \
            font_weight=\"bold\">${RESULT}</span>"

        echo "$RESULT"
    fi
done
