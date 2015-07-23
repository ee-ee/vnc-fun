#!/bin/bash
# will get vnc screenshots for brazil
# usage: sudo ./scan-brazil.sh
# will scan brazil for port 5900
masscan --conf brazil.conf
awk '/^Host:/ { print $2 }' brazil-results > brazil-results-awked
nmap --script open-curtains.nse -n -Pn -p 5900 -iL brazil-results-awked
