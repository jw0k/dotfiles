#!/usr/bin/env bash

if [ -f /sys/class/power_supply/sony_controller_battery_*/capacity ]; then
    for i in /sys/class/power_supply/sony_controller_battery_*/capacity; do
        echo "🎮🔋 $(cat "$i")%"
        break
    done
fi
