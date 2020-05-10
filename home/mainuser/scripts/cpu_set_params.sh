#!/usr/bin/env bash

# workaround na to, ze procesor nie osiaga maksymalnej czestotliwosci w pewnych warunkach
wrmsr 0x1fc 0x2c005d

# pozwala na uzywanie turbostata bez uprawnien roota
chmod +r /dev/cpu/*/msr

# odśwież demona intel-undervolt (bez tego czasami po odhibernowaniu dziwnie sie zachowuje - sam się zmienia package power na nieprawidłowy)
pkill -USR1 intel-undervolt || echo "Cannot refresh intel-undervolt daemon"

# gnome keyring musi byc uruchomiony przed network managerem; bez tego network manager nie bedzie w stanie pobrac hasla do WiFi z keyringa i nie polaczy sie
#dbus-update-activation-environment --systemd DISPLAY
#eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
#export SSH_AUTH_SOCK

#DISPLAY=:0 eval $(/usr/bin/gnome-keyring-daemon --daemonize)
#export SSH_AUTH_SOCK
