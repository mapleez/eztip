#!/usr/bin/perl

# ---------------------------------
# Author : ez
# Create Date : 2015/10/12
# Describe : This module is just
#	for configuration file parsing.
# ---------------------------------

package ez_config;

use strict;
use warnings;
use IO::File;
# use Carp;

use Exporter;

our @ISA = qw (Exporter);
our @EXPORT_OK = qw (ez_config_parse ez_config_eachline);
our @EXPORT = qw (%CONF_VALUES);

my $CONF_FILE = "./conf";

# all the values parsed from
# config file, conf
our %CONF_VALUES;

sub ez_config_parse {
	my ($custom_file) = shift;
	$custom_file = $CONF_FILE
		unless $custom_file;
	my $conf_fd = IO::File -> 
		new ($custom_file, "+<");
	defined ($conf_fd) 
		or die ("Open Config file $custom_file error.");
	while (<$conf_fd>) {
		ez_config_eachline ($_);
	}
	print "config file $custom_file parsed.\n";
}

# parse each line,
# each config entity like this form:
#    Name = Value
sub ez_config_eachline {
	my $line = shift;
	if ($line) {
		unless ($line =~ /^#|\s*#/) {
			my ($k, $v) = $line 
				=~ /\s*(\w{1,})\s*=\s*(\w{1,})/;
			$k && $v && ($CONF_VALUES{$k} = $v);
		}
	}
}


1;
__END__
