#!/usr/bin/env bash

DEVNAME=$1

#export XAUTHORITY=/home/jacek/.Xauthority
#export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

[[ $2 == "add" ]] && jscal-restore $DEVNAME && \
    notify-send "PS4 controller connected at ${DEVNAME}" -t 3000

[[ $2 == "remove" ]] && \
    notify-send "PS4 controller disconnected from ${DEVNAME}" -t 3000

sleep 5
pkill -SIGRTMIN+10 i3blocks
