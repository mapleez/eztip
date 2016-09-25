#!/usr/bin/perl

# AUTHOR : ez
# DATE : 2015/10/31
# DESCRIBE : program in learning Perl 6th.
#    chapter 3

use warnings;
use strict;

# chapter 3

# program 1
sub print_reverse {
	my @array = <STDIN>;
	chomp @array;
	my $i = 0;
# while (<STDIN>) {
# push @array, chomp $_;
#	}
	for ($i = $#array; $i >= 0; -- $i) {
		print $array[$i], "\n";
	}
}

# &print_reverse;

# program 2
my @name_list = qw(
		fred betty barney dino
		wilma pebbles bamm-bamm
		);

sub print_name_list {
	my $length = $#name_list;
	my @indexes = ();
	while (<STDIN>) {
		if (/^\d{0,$length}$/) {
			my $line = $_;
			chomp $line;
			push @indexes, $line;
		} elsif (/q|quit/i) {
			exit 0;
		}
	}
	
	foreach (@indexes) {
		print $name_list[$_], " ";
	}
}

# &print_name_list;

# program 3
sub print_input_strings {
	my @strings = ();
	@strings = <STDIN>;
	chomp @strings;
	foreach (sort @strings) {
		print $_, " ";
	}
}

# &print_input_strings;

__END__


