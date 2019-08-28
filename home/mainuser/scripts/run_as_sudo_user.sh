#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
    me=$(basename "$0")
    echo "Usage: $me program_to_run"
    exit 1
fi

if [[ -z $SUDO_USER ]]; then
    $1
else
    sudo -E -u $SUDO_USER $1
fi
