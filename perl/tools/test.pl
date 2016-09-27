#!/usr/bin/perl

use strict;
use warnings;

use Getopt;

&opt ('a', 'append', 1);
&opt ('f', 'file', 1);
&opt ('e', 'execute', 0, 1);
&opt ('g', 'global', 0, 0);
&opt ('b', 'buffsize', 1, '32bytes');
&opt ('m', 'map', 0, 0);


&arg ('src');
&arg ('dst');

&_print_all;

&parse (@ARGV);

print 'x' x 20, "\n";

&_print_all;


__END__

