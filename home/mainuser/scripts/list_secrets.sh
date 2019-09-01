#!/usr/bin/env bash

echo "secrets from the login keyring:"
gkeyring --all -o id,name -O --keyring login

echo -e "\nsecrets from the default keyring:"
gkeyring --all -o id,name -O
