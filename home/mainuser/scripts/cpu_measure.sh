#!/usr/bin/env bash

first=true
counter=0
turbostat -q --interval 1 --show PkgWatt --cpu "" -S | while read line; do
    if [ "$first" = true ] ; then
        first=false
    else
        LIMIT=$(intel-undervolt read | grep -oP 'Long term package power: \K(\d+)')
        CURR=$(echo "$line" | LC_ALL=C xargs printf "%.*f\n" 0)
        if (( CURR < 10 )); then
            printf "%s" '%{F#00000000}0%{F-}'
        fi
        if (( CURR > 15 )); then
            (( counter++ ));
        else
            counter=0
        fi
        if (( CURR > 15 && counter > 12)); then
            printf "%s" '%{F#c31}%{T2}!%{T-}%{F-}'
        else
            printf "%s" '%{F#00000000}%{T2}!%{T-}%{F-}'
        fi
        if (( LIMIT > 15 )); then
            printf "%s" '%{B#844}'
        fi

        printf "%sW/%sW" "$CURR" "$LIMIT"

        if (( LIMIT > 15 )); then
            printf "%s" '%{B-}'
        fi
        if (( CURR > 15 && counter > 12)); then
            printf "%s" '%{F#c31}%{T2}!%{T-}%{F-}'
        else
            printf "%s" '%{F#00000000}%{T2}!%{T-}%{F-}'
        fi

        printf "\n"
    fi
done

