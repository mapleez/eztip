#!/usr/bin/perl

use strict;
use warnings;
use IO::File;


# only one file name
my $filename = $ARGV [0]
	if @ARGV > 0;

die "File doesn't exists!\n"
	unless (-r $filename);

=head
use original API open()
=cut
open FILE, $filename;
my @linenum = <FILE>;
print "File has ". scalar @linenum . " line\n";


=head
use IO::File
=cut
my $fh = IO::File -> new ($filename, "+<");
defined ($fh) or die "create IO::File error...\n";

while (<$fh>) {
	print $_;
}

__END__

author : ez
describe : use IO::File and open() to read and write a file.
date : 2016/9/8

