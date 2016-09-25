#!/usr/bin/perl

# ---------------------------------
# Author : ez
# Create Date : 2015/10/12
# Describe : This file is just
#	for unit tests.
# ---------------------------------

use strict;
use warnings;
# use ez_config;
# use ez_config qw(ez_config_parse CONF_VALUES);

# use vars qw (%main::);

# while (my ($k, $v) = each (%CONF_VALUES)) {
# 	print "$k $v\n";
# }

# &ez_config_parse ("ok");

while (my ($k, $v) = each (%main::)) {
	print "$k, $v\n";
}

# print %CONF_VALUES;
