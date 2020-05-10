#!/usr/bin/env bash

ACTION="?"
[[ $1 == "add" ]] && ACTION="connected"
[[ $1 == "remove" ]] && ACTION="disconnected"

export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"
notify-send "Bose QC II $ACTION" -t 3000

sleep 5
pkill -f bose_battery.sh$ --signal SIGUSR1
