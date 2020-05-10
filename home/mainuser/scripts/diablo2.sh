#!/usr/bin/env bash

set -x

xbindkeys -f /home/mainuser/scripts/diablo2_bindkeys
sudo python /home/mainuser/scripts/diablo2_keyevents.py &
pid=$!
wine /home/jacek/.wine/drive_c/Program\ Files/Diablo\ II/Mod\ PlugY/PlugY.exe | cat
sudo kill -9 $pid
killall xbindkeys
