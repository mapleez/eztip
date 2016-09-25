#!/usr/bin/perl

#
# author : ez
# desc : test grep function.
# date : 2016/9/2
#

use strict;
use warnings;

# print my @line = grep '.pl$', `ls`;

my @path = split /:/, $ENV {'PATH'};
foreach my $p (@path) {
	my @res = grep /^jar$/, `ls $p`;
	# goto START if (@res);
	if (@res) {
		print $p. "\n";
		print "@res";
	}
}


__END__
