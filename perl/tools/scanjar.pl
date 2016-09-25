#!/usr/bin/perl

use strict;
use warnings;

# version string
use constant version => "1.1";

# handle input files.
if (@ARGV == 0) {
	print "You'd better provide a command.\n";
	&_help ();
}

my $cmd = $ARGV [0];
my @orignalfiles = @ARGV [ 1 .. (scalar @ARGV) - 1 ];
my @files = ();
my %cmds = ( 
	list => \&_list,
	search => \&_search,
	help => \&_help,
);

# if there isn't input files or the command is invalid.
unless (@orignalfiles && exists $cmds {$cmd}) {
	print "You'd better provide a list of jar files name. Or I don't now your command $cmd\n" ;
	&_help ();
}

# Make sure the input files is existing.
foreach my $f (@orignalfiles) {
	if (-r $f) {
		push @files, $f;
	} else {
		print "$f doesn't exist.\n";
	}
}

# Check wether JDK is installed, jar tool.
my @env = @ENV {'JAVA_HOME', 'PATH'};
unless ($env [0] && -r "$env[0]/bin/jar") {
	# if $JAVA_HOME cannot be setted, find jar tool
	# from $PATH
	if ($env [1]) {
		my @path = split /:/, $env [1];
		foreach my $p (@path) {
			my @res = grep /^jar$/, `ls $p`;
			goto START if (@res);
		}
		die "Please! You have not the jar tool in JDK.\n";
	}
	die "Please! You have not set environment variable \$PATH.\n";
}

# start length
START:
print "Start scan\n";

&{$cmds {$cmd}} ();

########################################
# Command functions. For every command.#
########################################

# list command.
sub _list {
	foreach my $f (@files) {
		print "Classes in file $f:\n".
			`jar -tf $f`.
			"-" x 40, "\n";
	}
}

sub _search {
	my ($exp, @res) = ($orignalfiles [0], ());
	unless (length $exp) {
		print "Error, please specify regular expression.\n";
		&_help;
	}

	foreach my $f (@files) {
		my $num = push @res, grep /$exp/, `jar -tf $f`;
		print "Found $num in $f\n";
		if ($num) {
			foreach my $r (@res) {
				print "  $r";
			}
		}
	}
}

# help command
sub _help {
	my $help_str = "Version " 
		. version . ", ";
	$help_str .=<<END;
A tool to scan jar file.
Usage: 
	scanjar.pl <command> jarfile1.jar [ jarfile2.jar ...]
Command:
	list:  list all class in input files.
	search: search a class in input files. the second arg must be perl regular expression.
	help:  print this help text.
END
	print $help_str;
	exit (0);
}

__END__

Author : ez
Date : 2016/9/1
Describe : This script is to scan and search java jar file.

