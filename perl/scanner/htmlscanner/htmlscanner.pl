#!/usr/bin/perl

# author : ez
# data : 2015/9/20
# describe : this is a simple mssql service 
#      scanner, use -h option to get help

use strict;
use warnings;
use Getopt::Args;
use IO::Socket::INET;

our $VERSION = 'v1.1';

opt url => (
	isa => 'Str',
	alias => 'h',
	comment => 'Host address, maybe domain name, or ip.',
);

opt help => (
	isa => 'Bool',
	comment => 'Print help string.',
	alias => 'h',
	ishelp => 1
);
