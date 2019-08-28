#!/usr/bin/env bash

DEVNAME=$1

#export XAUTHORITY=/home/jacek/.Xauthority
#export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

jscal-restore $DEVNAME
notify-send "PS4 controller connected at ${DEVNAME}" -t 4000

