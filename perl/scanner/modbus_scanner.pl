#!/usr/bin/perl

# author : ez
# date : 2015/9/25
# describe : a simple modbus scanner, use
#    -h option for help text.

use strict;
use warnings;
use IO::Socket::INET;
use Protocol::Modbus;
use Getopt::Args;
use POSIX;

our $VERSION = 'v1.0';

arg host => (
	required => 1,
	isa => 'Str',
	comment => 'Host address, maybe domain name, or ip.',
);

arg port => (
	isa => 'Int',
	required => 1,
	comment => 'modbus server tcp port.',
);

arg addresses => (
	isa => 'Str',
	required => 1,
	comment => 'modbus registers address. separated by comma(,).'
);

opt help => (
    isa => 'Bool',
	comment => 'Print help string.',
	alias => 'h',
	ishelp => 1
);

opt rcvbuff => (
	isa => 'Int',
	comment => 'Separate the receive buffer length, default 1024',
	alias => 'r',
	default => 1024,
);


my ($url, $port, 
	$rcvdata, $options, $len,
	@addrs) = (undef, undef,
				undef, undef, undef, 
				());

{
# initialization:
	$options = optargs () or
		die usage ();
	@addrs = split /,/, $options -> {addresses};
	$url = $options -> {host};
	$port = $options -> {port};
	$len = $options -> {rcvbuf} ? $options -> {rcvbuf} : 1024;
}

my $sock = new IO::Socket::INET (
		PeerAddr => $url,
		PeerPort => $port,
		Proto => 'tcp',
		Type => SOCK_STREAM
	) or 
	die ("Error in socket Creation : $!\n");

my $proto = Protocol::Modbus -> new (
	driver => 'TCP',
	transport => 'TCP'
);

my $request = $proto -> request (
	function => Protocol::Modbus::FUNC_READ_HOLD_REGISTERS,
	address => @addrs,
	quantity => scalar (@addrs),
	unit => 1
);

while (1) {
	print '[>]Sending(', 
		  POSIX::strftime ('%F %T', localtime), 
		  ') :',
		  $request -> stringify (), "\n";

	$sock -> send ($request -> pdu ());

	# if successful, recv return 0
	$sock -> recv ($rcvdata, $len);
	next unless $rcvdata;

	my ($flag, $version,
		$length, $deviceid,
		$func, $bytes, 
		@vals) = unpack ('SSnCCCn*', $rcvdata);
	print "[<]Received(", 
		  POSIX::strftime ('%F %T', localtime), 
		  ") :\n";
	for (my $i = 0; $i < @vals; $i ++) {
		print "$addrs[$i]: $vals[$i]\n";
	}

	print "\n";
	sleep (1);
}

$sock -> close ();

__END__
