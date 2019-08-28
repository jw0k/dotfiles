#!/usr/bin/env bash

set -e # stop on first error

if [ "$#" -ne 1 ]; then
    me=`basename "$0"`
    echo "Usage: $me vm_name"
    exit 1
fi

vboxmanage unregistervm $1 --delete
