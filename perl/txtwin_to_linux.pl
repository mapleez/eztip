#!/usr/bin/perl

use strict;
use warnings;

my $dir = shift @ARGV;
die "please enter the directory.\n"
	unless $dir;

my @files = `ls $dir`;

foreach my $fname (@files) {
	$fname =~ s/\s//g;
	open FILE, "$dir/$fname"
		or die ("cannot open $fname");
	while (<FILE>) {
		$_ =~ s/\r\n//g;
		print "$_";
# `echo "$_" >> $dir/$fname.back`;
	}
	close (FILE);
#	`rm $dir/$fname`;
# 	`mv $dir/$fname.back $dir/$fname`;
}

__END__
