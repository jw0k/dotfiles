#!/usr/bin/env bash

find /etc -regextype posix-extended -regex ".+\.pacnew" 2> /dev/null
