#!/usr/bin/env bash

for i in /sys/class/power_supply/sony_controller_battery_*/capacity; do
    echo "$(cat "$i")%"
done
