#!/usr/bin/perl

# AUTHOR : ez
# DATE : 2015/10/31
# DESCRIBE : program in learning Perl 6th.
#    chapter 2

# chapter 2 

use strict;
use warnings;


# program 1
sub circumference {
	use Math::Trig ':pi';
	my $radius = shift;
	pi * $radius * 2 
}

# print &circumference (12.5);

# program 2, 3
sub input_radius {
	while (<STDIN>) {
		if (/^\-?\d{1,}\.?\d*$/) {
			print "The circumference is ", 
				  $_ > 0 ? &circumference ($_) : 0, " with radius = $_\n";
		} elsif (/quit|q/i) {
			exit 0;
		} else {
			print "please input digits.\n"
		}
	}
}

# &input_radius;

# program 4
sub multiply ($$) {
	my ($a, $b) = @_;
	$a * $b;
}

sub input_multiply {
	print "digit a>";
	while (<STDIN>) {
		my $a = $_;
		print "digit b>";
		my $b = <STDIN>;
		chomp $a;
		chomp $b;
		if ($a =~ /^\-?\d{1,}\.?\d*$/ &&
			$b =~ /^\-?\d{1,}\.?\d*$/)
		{
			print "$a * $b = ",
				&multiply ($a, $b), "\n";
		} elsif ($a =~ /quit|q/i ||
				 $b =~ /quit|q/i) {
			exit 0;
		} else {
			print "enter two digits.\n";
		}
		print "digit a>";
	}
}

# &input_multiply ;

# program 5
sub output_times {
	my ($str, $times) = @_;
	if ($str && $times) {
		print $str x $times, "\n";
	}
}

sub main {
	print "string >";

	while (<STDIN>) {
		my $str = $_;
		print "times >";
		my $times = <STDIN>;
		chomp $times;
		if ($times =~ /^\d{1,}$/) {
			&output_times ($str, $times);
		}
		print "string >";
	}
}

# &main;

__END__
