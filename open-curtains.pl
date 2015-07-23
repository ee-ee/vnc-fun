#!/usr/bin/perl -w
#
 
use strict;
use IO::Socket::INET;
 
my ($data, $security) = undef;
my ($hostname, $port) = @ARGV;
 
$SIG{ALRM} = sub {
	die "[$hostname:$port] Timed out.\n";
};
 
warn "[$hostname:$port] Trying to connect and snapshot.\n";
 
my $client = new IO::Socket::INET(
		PeerHost => $hostname,
		PeerPort => $port,
		Proto => "tcp",
		Timeout => 30
	) or die "[$hostname:$port] Unable to connect: $!.\n";
 
alarm(30);
$client->recv($data, 512);
if ($data =~ /^RFB .*/) {
	$client->send("RFB 003.003\n");
} else {
	die "[$hostname:$port] Unexpected response when negotiating.\n";
}
 
alarm(30);
$client->recv($data, 512);
if (unpack("H*", $data) =~ /00000001/) {
	$security = 0;
}
 
$client->close();
 
alarm(120);
if (defined($security)) {
	warn "[$hostname:$port] Taking snapshot.\n";
	system("vncsnapshot -vncQuality 7 -quality 70 " . $hostname . ":" . ($port - 5900) . " " . $hostname . "_" . $port . ".jpg >/dev/null 2>&1");
} else {
	warn "[$hostname:$port] Password required - ignoring.\n";
}
