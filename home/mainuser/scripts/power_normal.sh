#!/usr/bin/env bash

sed -i 's/^power package.*/power package 40\/2 15/' /etc/intel-undervolt.conf
intel-undervolt apply
