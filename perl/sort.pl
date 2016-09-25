#!/usr/bin/perl

use strict;
use warnings;

# data define
my @dig = ('0' .. '9');
my @alf = (
	'a' .. 'z',
	'A' .. 'Z');
my @symbol = qw/! & $ @ % ^ */;
my @arr = (
	@dig, @alf, @symbol
);

# sort dig:
print sort {$a < $b} @dig;
print "\n" . '-' x 54 . "\n";

print sort {$a le $b} @alf;


__END__

#
# author : ez
# date : 2016/9/5
# describe : test sort function.
#
