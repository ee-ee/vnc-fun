#!/bin/bash
# will get vnc screenshots for brazil
# usage: sudo ./scan-brazil.sh
# will scan brazil for port 5900
masscan --conf brazil.conf
awk '/^Host:/ { print $2 }' brasil-results > brasil-results-awked
nmap --script open-curtains.nse -n -Pn -p 5900 -iL brasil-results-awked
