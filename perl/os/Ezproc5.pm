#!/usr/bin/perl

# author : ez
# date : 2015/12/22
# describe : a simple Process model with 5 status.

package Ezproc5;

use strict;
use warnings;
use Exporter;

use vars qw ($VERSION @ISA @EXPORT @EXPORT_OK);

@ISA = qw (Exporter);
@EXPORT = @EXPORT_OK;
@EXPORT_OK = qw (new exit blocking ready running);

our $VERSION = "1.0";
my ($newer, $ready, $running, $exit, $blocking) = (
		"new", "ready", "running", "exit", "blocking"
);

sub new {
	my $class = shift;
	my $self = {
		name => shift,
		img => shift,
		status => $newer
	};

	bless $self, $class;
	$self;
}


sub exit {
	my $self = shift;
	$self -> {status} = $exit;
	print "proc $self->{img} status switch to \"$self->{status}.\"\n"
}

sub blocking {
	my $self = shift;
	$self -> {status} = $blocking;
	print "proc $self->{img} status switch to \"$self->{status}.\"\n"
}

sub ready {
	my $self = shift;
	$self -> {status} = $ready;
	print "proc $self->{img} status switch to \"$self->{status}.\"\n"
}

sub running {
	my $self = shift;
	$self -> {status} = $running;
	print "proc $self->{img} status switch to \"$self->{status}.\"\n"
}

1;

__END__

