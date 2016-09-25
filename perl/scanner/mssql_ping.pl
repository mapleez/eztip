#!/usr/bin/perl

# author : ez
# data : 2015/9/20
# describe : this is a simple mssql service 
#      scanner, use -h option to get help

use strict;
use warnings;
use Getopt::Args;
use IO::Socket::INET;

our $VERSION = 'v1.1';

arg url => (
		required => 1,
		isa => 'Str',
		comment => 'Host address, maybe domain name, or ip.',
);

opt help => (
    isa => 'Bool',
	comment => 'Print help string.',
	alias => 'h',
	ishelp => 1
);

opt port => (
		isa => 'Int',
		alias => 'p',
		comment => 'mssql tcp port. default as 1045.',
		default => 1434 
);

my $options = optargs ();

my ($port, $url) = ($options -> {'port'}, 
   $options -> {'url'});
$port && $url
	|| die usage ();
$options -> {help} && die usage ();

my $sock = new IO::Socket::INET (
		PeerAddr => "$url:$port",
		Proto => 'udp'
		)
or die ("Error in socket Creation : $!\n");
my ($data, $rcvdata, $len) = ("\x02", undef, 1024);

$sock -> send ($data);
recv ($sock, $rcvdata, 1024, 0)
	or die "Error in data receiving : $!\n";

$sock -> close ();

my @sql_instances = split /;;/, $rcvdata;
foreach my $instance (@sql_instances) {
	my $val = undef;
	my %hash = ();
	my $one = substr $instance, index ($instance,"ServerName");
	next unless $one;
	print "-" x 10 . "\n";
	my @key_vals = split /;/, $one;
	%hash = @key_vals;
# 	foreach (@key_vals) {
# 		if (! $val) {
# 			$val = $_;
# 		} else {
# 			$hash {$val} = $_;
# 			$val = undef;
# 		}
# 	}
	foreach (keys %hash) {
		print "$_ => $hash{$_}\n";
	}
}


__END__
