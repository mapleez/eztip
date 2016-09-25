#!/usr/bin/perl

# author : ez
# date : 2015/12/22
# describe : a simple Process model with 2 status.

package Ezproc2;

use strict;
use warnings;
use Exporter;

use vars qw ($VERSION @ISA @EXPORT @EXPORT_OK);

@ISA = qw (Exporter);
@EXPORT = @EXPORT_OK;
@EXPORT_OK = qw (new2 _start2 _stop2);

our $VERSION = "1.0";

my ($start2, $end2) = ("running", "stopping");

sub new2 {
	my $class = shift;
	my ($name, $img) = (shift, shift);
	my $self = {
		# process name
		name => $name,

 		# image path or cmd line
		img => $img,

		# status constance
		status => $start2,
	};

	bless $self, $class;
	$self;
}

sub _start2 {
	my $class = shift;
	$class -> {status} = $start2;
	print "running process \"$class->{'img'}\" status",
				"\"$class->{'status'}\"\n";
}

sub _stop2 {
	my $class = shift;
	$class -> {status} = $end2;
	print "stopping process \"$class->{'img'}\" status",
		"\"$class->{'status'}\"\n";
}


1;

__END__
