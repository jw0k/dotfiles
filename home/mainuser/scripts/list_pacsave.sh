#!/usr/bin/env bash

find /etc -regextype posix-extended -regex ".+\.pacsave" 2> /dev/null
