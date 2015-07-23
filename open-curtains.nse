-- Head
description = [[Take snapshots from VNC servers not requiring authentication]]
author = "David Ramsden"
license = "Same as Nmap--See http://nmap.org/book/man-legal.html"
categories = {"default", "safe"}
 
-- Rule
portrule = function(host, port)
	return port.protocol == "tcp"
		and port.state == "open"
end
 
-- Action
action = function(host, port)
	os.execute("./open-curtains.pl "..host.ip.." "..port.number.." &")
 
	return "Trying to snapshot."
end
