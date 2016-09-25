#!/usr/bin/perl

# author : ez
# date : 2016/2/18
# describe : for train compute.

use strict;
use warnings;

# if (scalar @ARGV < 1) {
# 	print "ERROR: give me datas.\n";
# 	exit (0);
# }

my %hash = ();
&version;

# received data from cat command with pipe |.
while (<>) {
	chomp (my $line = $_);
	if ($line =~ /^#/) {
		$line =~ /^#\s*/;
		print "$'\n";  # backwords.
	} elsif ($line =~ /^\s*$/) { # empty line.
		next;
	} else {
		my ($name, $expr) = ();
		if ($line =~ /(^\w+)\s*:\s*(.*)/) {
			chomp ($name = $1); chomp ($expr = $2);
			chomp ($expr = `echo $expr | bc`) if $expr ne '';
			$expr = 0 unless $expr ne '';
			$hash {$name} = 0 if $name ne '' && 
				! exists $hash {$name};
			$hash {$name} += $expr 
				if $name ne '' && exists $hash {$name};
			print "$name = $expr\n";
		} else {
			print "ERROR: cannot parse express.\n";
		}
	}
}


print "-" x 10, "\nStatistic: \n";
while (my ($k, $v) = each %hash) {
	print "$k = $v\n";
}

sub version {
print <<EOF
This program is to process my train statistic.
Powered by ez.
2016/2/18 Version 1.1 

EOF
}

__END__

The file format is alike below:

# 2016/2/17:
switch: 35+16+18+20+20+10+20
dun: 70+30+40+40

# 2016/2/18:
switch: 20
dun: 


