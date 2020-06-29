#!/usr/bin/env bash

ACTION="?"
[[ $1 == "add" ]] && ACTION="connected"
[[ $1 == "remove" ]] && ACTION="disconnected"

export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"
notify-send "JBL GO 2 $ACTION" -t 3000
