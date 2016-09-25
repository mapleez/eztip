#!/usr/bin/perl

# AUTHOR : ez
# DATE : 2015/10/31
# DESCRIBE : program in learning Perl 6th.
#    chapter 4

use warnings;
use strict;

# chapter 4

# program 1
sub total {
	my @nums = @_;
	my $sum = 0;
	foreach (@nums) {
		$sum += $_
			if /^\d{1,}$/;
	}
	$sum;
}

=head the uniting test
my @fred = qw{1 3 5 7 9};
my $fred_total = total (@fred);
print "The total of \@fred is $fred_total.\n";
print "Enter some numbers on separate lines:";
my $user_total = total (<STDIN>);
print "The total of those numbers is $user_total.\n";
=cut;

# program 2
sub total_1_to_1000 {
	print "the total of adding 1 up to 1000 is ",
		  &total (1..1000);
}

# &total_1_to_1000;

# program 3
sub above_average {
	my @array = ();
	my $tmp = 0;
	foreach (@_) {
		$tmp += $_;
	}
	$tmp /= scalar (@_)
		if 0 < scalar @_;

	foreach (@_) {
		push @array, $_
			if $_ > $tmp;
	}
	@array;
}

=head the unit testing...
my @fred = above_average (1..10);
print "\@fred is @fred\n";
# print "@fred";
print "(Should be 6 7 8 9 10)\n";
my @barney = above_average (100, 1..10);
print "\@barney is @barney\n";
print "(Should be just 100)\n";
=cut;


# program 4
use 5.010;

sub greet {
	state $persons = [];
	my $name = shift;
 	if (!@{$persons} && $name) {
 		print "Hi $name, ", 
 			  "You are the first one here!\n";
 		push @{$persons}, $name;
 	} elsif ($name) {
 		print "Hi $name! ", $persons -> [-1],
 			  " is also here!\n";
 		push @{$persons}, $name;
 	}
}

=head test state subroutine
# &greet ("Fred");
# &greet ("Barney");

sub greet {
	state $n = 0;
	$n += 1;
	print "$n\n";
}

&greet ();
&greet ();
&greet ();
&greet ();
&greet ();
=cut;

# program 5
use 5.010;
sub greet_v2 {
	state $persons = [];
	my $name = shift;
 	if (!@{$persons} && $name) {
 		print "Hi $name, ", 
 			  "You are the first one here!\n";
		push @{$persons}, $name;
 	} elsif ($name) {
 		print "Hi $name! I've seen: @$persons\n";
 		push @{$persons}, $name;
 	}
}

# &greet_v2 ("Fred");
# &greet_v2 ("Barney");
# &greet_v2 ("Wilma");
# &greet_v2 ("Betty");


__END__

