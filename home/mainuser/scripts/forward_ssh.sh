#!/usr/bin/env bash

while true
do
    ssh -R dom:22:localhost:22 serveo.net
    sleep 10
done

