#!/usr/bin/perl

use strict;
use warnings;

# ???
eval {
# 	my @x = (1 .. 10);
# 	print @x;
};


sub a {
}

sub b {}

sub c {}

open FILE, '/usr/private/driver.txt'
	or die "cannot open file";

# :-)
binmode FILE, ':bytes';

my $file = <FILE>;

my $x =1;

__END__
