#!/usr/bin/perl

# AUTHOR : ez
# DATE : 2015/11/3
# DESCRIBE : program in learning Perl 6th.
#    chapter 7 

use warnings;
use strict;

# chapter 7

# program 1

sub mention_fred {
	chomp (my @lines = <>);
	my $lineNo = 1;
	foreach (@lines) {
		$lineNo ++;
		print "$lineNo  $_\n"
			if /fred/;
	}
}

# &mention_fred;

# program 2
sub mention_F_fred {
	chomp (my @lines = <>);
	my $lineNo = 1;
	foreach (@lines) {
		$lineNo ++;
		# /fred|Fred/, /[fF]red/
		print "$lineNo  $_\n"
			if /(f|F)red/;
	}
}

# &mention_F_fred;

# program 3
sub print_period {
# chomp (my @line = <>);
	my @line = <>;
	my $lineNo = 1;
	foreach (@line) {
		print "$lineNo  $_"
			if /\./;
		$lineNo ++;
	}
}

# &print_period;

# program 4
sub capitalized {
	my @line = <>;
	my $lineNo = 1;
	foreach (@line) {
		print "$lineNo  $_"
			if /[A-Z][a-z]+/;
		$lineNo ++;
	}
}

# &capitalized;

# program 5


__END__
