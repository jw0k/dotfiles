#!/usr/bin/env bash

vboxmanage list vms | grep "<inaccessible>" | cut -d ' ' -f 2 | while read line;
do
    vboxmanage unregistervm $line
done

