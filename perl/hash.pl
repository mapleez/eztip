#!/usr/bin/perl

use strict;
use warnings;

my %hash = (
	0 => 'Mon',
	1 => 'Tus',
	2 => 'Wed',
	3 => 'Thu',
	4 => 'Fri',
	5 => 'Sat',
	6 => 'Sun'
);

print %hash;
print "\n";

print reverse %hash;

__END__

