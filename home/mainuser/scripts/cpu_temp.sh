#!/usr/bin/env bash

first=true
counter=0
turbostat -q --interval 1 --show PkgTmp --cpu "" -S | while read line; do
    if [ "$first" = true ] ; then
        first=false
    else
        if (( line > 70 )); then
            (( counter++ ));
        else
            counter=0
        fi
        if (( line > 70 && counter > 12 )); then
            printf "%s" '%{F#c31}%{T2}!%{T-}%{F-}'
        else
            printf "%s" '%{F#00000000}%{T2}!%{T-}%{F-}'
        fi

        printf "%s°C" "$line"

        if (( line > 70 && counter > 12 )); then
            printf "%s" '%{F#c31}%{T2}!%{T-}%{F-}'
        else
            printf "%s" '%{F#00000000}%{T2}!%{T-}%{F-}'
        fi

        printf "\n"
    fi
done

