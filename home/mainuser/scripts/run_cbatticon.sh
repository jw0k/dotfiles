#!/usr/bin/env bash

if [ -f /sys/class/dmi/id/chassis_type ]; then
    CHASSIS_TYPE=$(cat /sys/class/dmi/id/chassis_type)
    if [[ $CHASSIS_TYPE == 8 ||
          $CHASSIS_TYPE == 9 ||
          $CHASSIS_TYPE == 10 ||
          $CHASSIS_TYPE == 11 ||
          $CHASSIS_TYPE == 14 ]]; then
        cbatticon
    fi
fi
