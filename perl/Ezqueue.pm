
#!/usr/bin/perl

package Ezqueue;

use strict;
use warnings;
use Exporter;
use vars qw (@ISA @VERSION @EXPORT @EXPORT_OK);

@ISA = qw (Exporter);
@EXPORT = @EXPORT_OK;
@EXPORT_OK = qw (push pop count new);
our @VERSION = "1.0";

sub new {
	my $class = shift;
	my $self = []; 
	bless $self, $class;
	$self;
}

sub push {
	my ($self, $value) = (shift, shift);
	push @$self, $value; 
	1;
}

sub count {
	my $self = shift;
	scalar @$self;
}

sub pop {
	my $self = shift;
	shift @$self;
}

1;
__END__
