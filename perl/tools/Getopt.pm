#!/usr/bin/perl

package Getopt;

use strict;
use warnings;
use vars qw /@ISA @EXPORT/;

require Exporter;
@ISA = qw (Exporter);
@EXPORT = qw /opt parse/; # _print_all/;

# ========= configuration ==========
# my $prefix = '-';
# my $longprefix = '--';
# ==================================

my  %options = ();
my  %options_long = ();
my  @argtmp = ();

=head
Register options
 return 0 if input is error.
 return -1 if failure.
 return 1 if successful.
=cut;
sub opt {
	if (3 < scalar @_) {
		print "Error, arguments is not enough.\n";
		return 0;
	}
	my ($short, $long, $param) = @_;

	if (length $short && 
		! exists $options {$short}) {
		$options {$short} = {
			short => $short, 
			long  => $long, 
			param => $param, 
			value => ''
		};
		# get reference for long option.
		$options_long {$long} = $options {$short}; 
		return 1;
	}
	return -1;
}

=head
Parse option and return.
param: args
=cut;
sub parse {
	my @args = @_; # @ARGV;
	for (my $i = 0; $i <= $#args; $i ++) {
		my $a = $args [$i];

		# long or short param
		my ($opt, $entry) = (&_parse_opt ($a), undef);
			if ($opt ne "-1") {
				$entry = $options_long {$opt} 
					if 1 < length $opt && exists $options_long {$opt};
				$entry = $options {$opt}
					if 1 == length $opt && exists $options {$opt};

				unless (defined $entry) {
					die "Error, unknown option \'$opt\'\n";
				}
				$entry -> {value} = $args [++ $i]
					if $entry -> {param};
			} else {
 				# $opt == -1
				push @argtmp, $a;
			}
	}
}

=head Parse option and return.
return parsed option
  if length > 1, long option
  if length == 1, short option
  if return -1, arg
  die if error.
=cut;
sub _parse_opt {
	my ($opt, $short, $long) = 
		(shift, "", "");
	die "Error input param in &_parse_opt\n"
		unless length $opt;
	if ($opt =~ /^-(\w)|^--(\w{1,})/) {
		($short, $long) = ($1, $2);
		return $short if $short && 1 == length $short;
		return $long if $long && 1 < length $long;
		die "Error input option \'$opt\'\n";
	} 
	"-1";
}

# for debug
sub _print_all {
	print "Input options: @ARGV\n";
	print "-" x 20 , "\n";

	while (my ($key, $val) = each %options) {
		print "$key:\n";
		while (my ($k, $v) = each %$val) {
			print " $k => $v\n";
		}
	}

	print "-" x 7, " args ", "-" x 7, "\n";
	print "@argtmp\n";
}


1;

__END__

author : ez
date : 2016/9/18
describe : 
	1) short option start with '-'
	2) long option start with '--'
	3) the short option cannot be combined with each other starting with '-'. That is.
		The format --abcd (-a -b -c -d) is not supported.
	4) when input an unregister option, print error text and continue parsing next input.


