#!/usr/bin/perl

use strict;
use warnings;
use IO::Socket::INET;
use Getopt::Args;


arg url => (
		required => 1,
		isa => 'Str',
		comment => 'Host address, maybe domain name, or ip.',
);


arg port => (
		required => 1,
		isa => 'Int',
		comment => 'Host port.',
);

=head test split ()
my $str = "fasfsdfds";

foreach (split ';', $str) {
	print "$_\n";
}
=cut

my $opt = optargs ();
my ($url, $port) = (
		$opt -> {url},
		$opt -> {port}
);

die usage ()
	unless ($url && $port);

my $sock = new IO::Socket::INET (
		PeerAddr => "$url:$port",
		Proto => 'udp'
		)
or die ("Error in socket Creation : $!\n");
print "enter: \n";
while (<>) {
	my $data = $_;
	my ($rcvdata, $len) = (undef, 1024);
	$sock -> send ($data);
	recv ($sock, $rcvdata, 2048, 0)
		or die "Error in data receiving : $!\n";
	print $rcvdata;
}

$sock -> close ();

