#!/bin/bash
# will get vnc screenshots for your chosen range
# usage: sudo ./scan-range.sh 200
# will scan 200.*.*.* for port 5900
masscan -p 5900 $1.0.0.0/8 -oG vnc --rate=100000
awk '/^Host:/ { print $2 }' vnc > vnc-$1
nmap --script open-curtains.nse -n -Pn -p 5900 -iL vnc-$1
