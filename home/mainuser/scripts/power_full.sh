#!/usr/bin/env bash

sed -i 's/^power package.*/power package 50\/2 50/' /etc/intel-undervolt.conf
intel-undervolt apply
