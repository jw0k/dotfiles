#!/usr/bin/env bash

# przywróć oryginalną wartość 0x1fc
wrmsr 0x1fc 0x24005d

# przywróć fabryczne napięcia na CPU/GPU

mv /etc/intel-undervolt.conf /etc/intel-undervolt.conf.orig
mv /etc/intel-undervolt-shutdown.conf /etc/intel-undervolt.conf

pkill -USR1 intel-undervolt || echo "Cannot refresh intel-undervolt daemon"
intel-undervolt apply

mv /etc/intel-undervolt.conf /etc/intel-undervolt-shutdown.conf
mv /etc/intel-undervolt.conf.orig /etc/intel-undervolt.conf
