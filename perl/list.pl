#!/usr/bin/perl

use strict;
use warnings;
use List::MoreUtils qw (mesh);

=head
Define list.
=cut
my @a = (1..20);
my @b = (30..50);
my @c = ('a' .. 'z');
my @d = ('A' .. 'Z');
my @e = ('0' .. '9', @c, @d);
my @strings = qw/
	faefae fnkja 
	jfkejan lkjjk klja 
	kjv kj lktjqlkj
	nfkl
/;

# use this to print all element.
# Separated with empty character.
print "@a";

=head Test List::MoreUtils::mesh
the function mesh () returns a list consisting
of the first elements of each array, then the second,
then the third, etc, until all arrays are exhausted.
=cut
if (1) {
	my @nums = mesh @a, @b;
	foreach my $x (@nums) {
		unless (defined ($x)) {
			print "Wow!!!\n";
		} else {
			print "$x\n";
		}
	}
}


my $first = shift @a;
push @a, $first;

print "";


__END__

author : ez
description : the test for list.
date : 2016/9/8

