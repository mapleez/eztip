#!/usr/bin/perl

# author : ez
# date : 2015/7/21
# describe : --

package Phone;

use strict;
use warnings;


@Phone::ISA = 'Scalar';

# our $VERSION = 1.0;

sub new {	
	my $class = shift;
	my ($_name, $_price, $_color) = (shift, shift, shift);
	my $self = {
		name => $_name,
		price => $_price,
		color => $_color
	};
	bless $self, $class;
	$self;
}


sub sftr  {
	my $self = shift;
# 	foreach (@Phone::ISA) {
# 		print "$_\n";
# 	}
	$self->SUPER::sftr ();
}

sub display {
	my $self = shift;
	print "name :". $self -> {'name'} .", price :". $self -> {'price'} .", color :". $self -> {'color'}. "\n";
}

1;
