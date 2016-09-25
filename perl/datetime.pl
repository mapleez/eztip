#!/usr/bin/perl

use strict;
use warnings;
use DateTime;

use constant Week => qw (Mon Tus Wed Thu Fri Sat Sun);
use constant Timestamp => scalar localtime;
use constant Timestamp2 => localtime;

# use Date::Format;
# my @lt = localtime (time);
# print time2str ("%c", time), "\n";
# print strftime ("%c", @lt), "\n";

my $date = DateTime -> new (
		year => 2016,
		month => 3,
		day => 20
);

print $date -> ymd (''), "\n";

my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime time ();
print "Today is ",  $year + 1900, "/$mon/$mday $hour:$min:$sec ", (Week)[$mday], "\n";
print Timestamp, "\n";
print "-" x 30, "\n";
print Timestamp2;

__END__
