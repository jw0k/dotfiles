#!/usr/bin/env python
import sys
import subprocess
if len(sys.argv) < 2:
    print("Usage: nmcli_toggle.py connection_id")
    sys.exit()
conn_id = sys.argv[1]
active = subprocess.check_output(['nmcli', 'connection', 'show', '--active'])
up_down = ('up', 'down')[conn_id in str(active)]
subprocess.call(['nmcli', 'connection', up_down, 'id', conn_id])
