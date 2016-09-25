#!/usr/bin/perl


use strict;
use warnings;


# return a float between [0, 1)
my $random_float = rand;

# return a float between [0, 10)
$random_float = rand 10;

# return a integer between [0, 10)
my $random_int = int rand 10;

# return a integer between [5, 20)
$random_int = int (5 + rand 20 - 5);


print;

__END__

author : ez
description : test for random function.
date : 2016/9/10

