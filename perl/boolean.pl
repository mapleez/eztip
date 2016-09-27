#!/usr/bin/perl

use strict;
use warnings;

my $a = "OK";
my $b = 1;
my $c = 0;
my $d = "";
my $x = "";

print "a ", !!$a, "\n";
print "b ", !!$b, "\n";
print "c ", !!$c, "\n";
print "d ", !$d, "\n";
print "x ", "\n" unless defined $x;
print "x ", !!defined $x, "\n";


__END__

