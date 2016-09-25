#!/usr/bin/perl

# AUTHOR : ez
# DATE : 2015/10/31
# DESCRIBE : program in learning Perl 6th.
#    chapter 5

use warnings;
use strict;

# chapter 5

# program 1 
sub tac {
	print reverse <>;
#	print reverse <>;
# 	my @files = ();
# 	my $fd = undef;
# 	die "Intput file name !\n"
# 		unless @_;
# 	@files = reverse @_;
# 	foreach my $file (@files) {
# 		if (-e $file) {
# 			print `cat $file`;
# 		}
# 	}
}

# &tac ();

# program 2
sub right_justified {
	chomp (my @strings = <>);
	print scalar @strings, "\n";
	print "1234567890" x 7, 1..5, "\n";
	foreach (@strings) {
		printf "%20s\n", $_;
	}
}

# &right_justified;

# program 3
sub right_justified_column {
	chomp (my @arr = <>);
	my $column = shift @arr;
	die "The first argument must be digit [1, 32].\n"
		unless $column =~ /\d{1,32}/;
	print "1234567890" x 7, 1..5, "\n";
	foreach (@arr) {
		printf "%${column}s\n", $_;
	}
}

# &right_justified_column;

__END__

