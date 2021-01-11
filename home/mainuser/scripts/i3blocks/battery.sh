#!/usr/bin/env bash

function disp {
    RESULT=$(based-connect -b 2C:41:A1:82:AB:51 2>/dev/null)
    if [ -z $RESULT ]; then
        echo ""
    else
        echo "🎧🔋 ${RESULT}%"
    fi
}

trap disp SIGUSR1

first=true
elapsedSec=$SECONDS
while :; do
    if pacmd list-sinks | awk '/^\s*\*/{f=2}/^\s*index:/{f=0}f' | grep "bluetooth" > /dev/null; then
        if (( $SECONDS - $elapsedSec > 120 )) || $first == true; then
            elapsedSec=$SECONDS
            disp
            if [ -z $RESULT ]; then
                first=true
            else
                first=false
            fi
        fi
    else
        first=true
        echo ""
    fi
    sleep 15 &
    wait $!
done
