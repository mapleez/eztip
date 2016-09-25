#!/usr/bin/perl	

use strict;
use warnings;

my $x = 23432.;

print $x;

while (1) {
	print "Enter string to match\$";
	chomp (my $string = <STDIN>);
	exit (0) if $string =~ /quit|q|Q|QUIT|exit|EXIT/;
  if ($string =~ /^-?\d+\.?\d*$/) {# /-?([1-9]\d*\.?\d*)|(0?\.?\d*0*)/;
 		print "OK! You type $string:$`--$&--$'\n";
 	}
}

__END__

