#!/usr/bin/env bash

awk '{print $1}' < /proc/loadavg | LC_ALL=C xargs printf "%.*f\n" 1

