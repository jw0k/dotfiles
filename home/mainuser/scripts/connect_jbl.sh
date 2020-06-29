#!/usr/bin/env bash

bluetoothctl remove B8:F6:53:CA:B3:C4
bluetoothctl -t 3 scan on
bluetoothctl trust B8:F6:53:CA:B3:C4
bluetoothctl pair B8:F6:53:CA:B3:C4
bluetoothctl connect B8:F6:53:CA:B3:C4
