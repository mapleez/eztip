#!/usr/bin/perl

use warnings;
use strict;

our $main = "Ok, It's in package main.\n";

package B;

our $bout = "Ok, It's in package B.\n";

package C;

my $c = "Ok, It's in package C.\n";
our $cout = "Ok, It's in package C.\n";

package D;

print $B::bout;
print $main::main;
print $C::c; # undefine.
print $C::cout;

__END__

author : ez
date : 2016/5/3
describe : This function is for package testing.

