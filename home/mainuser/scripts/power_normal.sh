#!/usr/bin/env bash

sed -i 's/^power package.*/power package 40\/2 25/' /etc/intel-undervolt.conf
pkill -USR1 intel-undervolt
intel-undervolt apply
