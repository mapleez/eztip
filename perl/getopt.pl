#!/usr/bin/perl

use warnings;
use strict;

ARG: while (@ARGV && $ARGV [0] =~ s/^-(?=.)//) {
OPT: for (shift @ARGV) {
		 m/^$/ && do {next ARG;};
		 m/^-$/ && do {last ARG;};
		 s/^d// && do {redo OPT;};
		 s/^l// && do {$debug_level ++; redo OPT;};
		 s/^l// && do {$generate_list ++; redo OPT;};
		 s/^i(.*)// && do {$in_place = $1 || ".bak"; next ARG};
		 &usage;
	 }
	}
