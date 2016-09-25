#!/usr/bin/perl

package Ezlist;

use strict;
use warnings;
use Exporter;
use vars qw (@ISA @VERSION @EXPORT @EXPORT_OK);

@ISA = qw (Exporter);
@EXPORT = @EXPORT_OK;
@EXPORT_OK = qw (getcount new push pop);
our @VERSION = "1.0";

sub _newelm {
	my $self = {
		next => undef,
		value => shift,
	};
	$self;
}


sub new {
	my $class = shift;
	my $self = {
		count => 0,
		first => undef
	};

	bless $self, $class;
	$self;
}

# sub getcapasity {
# 	my $self = shift;
# 	$self -> {capacity};
# }

sub getcount {
	my $self = shift;
	$self -> {count};
}

sub push {
	my ($self, $value, $ptr) = (shift, shift, undef);
	$ptr = $self -> {first};
	unless ($ptr) {
		$self -> {first} = &_newelm ($value);
		return 1;
	}

	while (defined $ptr -> {"next"}) {
		$ptr = $ptr -> {"next"};
	}

	# at this time $ptr should be undef.
	$ptr -> {next} = &_newelm ($value);
	$self -> {count} ++;
	1;
}

sub pop {
	my ($self, $ptr, $next, $res) = 
		(shift, undef, undef, undef);
	$ptr = $self -> {first};
	return undef unless $ptr;
	$next = $ptr -> {"next"};
	$res = $ptr -> {value};
	$self -> {first} = $next;
	$self -> {count} --;
	$res;
}


1;

__END__

