#!/usr/local/bin/perl
use strict;
use warnings;
require "tcp.pl";

use constant DEFAULT_PORT => 64139; 
use constant DEFAULT_ADDR => '127.0.0.1';

# global
my ($peer_sock, $continue,
	$rbuff, $rlen);

sub initialize {
	$peer_sock = -1;
	$continue = 1;
	$rbuff = '';
  $rlen = 0;
}

sub session {
	print "Start session!\n";
	while ($continue) {
		my $read_len = 
			&read_TCP ($peer_sock, \$rbuff);
		chomp $rbuff;
		if ($rbuff =~ /quit|QUIT|q|Q/) {
			print "Session closed!\n";
			&close_TCP ($peer_sock);
			last;
		}
		$rlen = &write_TCP ($peer_sock, \$rbuff);
		print "Sent it($rlen):$rbuff\n";
	}
}

my $rel;
LOOP:
&initialize;
	$peer_sock = &open_TCP (&DEFAULT_ADDR, &DEFAULT_PORT);
  print "[-] Try connecting...\n";
  if ($rel = &conn_TCP) {
  	# connected.
  	&session;
  }
	sleep 2;
goto LOOP;

__END__

