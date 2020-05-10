#!/usr/bin/env bash

killall -SIGUSR1 dunst
systemctl hibernate
i3lock --nofork --image $HOME/lock_screen.png
killall -SIGUSR2 dunst
