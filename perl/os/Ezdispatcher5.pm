#!/usr/bin/perl

# author : ez
# date : 2015/12/22
# describe : a simple round-robin dispatcher for os, only for 5-status
# 		process model.

package Ezdispatcher5;

use strict;
use warnings;
use Exporter;

use vars qw (@ISA @EXPORT @EXPORT_OK);

@ISA = qw (Exporter);
@EXPORT = @EXPORT_OK;
@EXPORT_OK = qw (dispatching regist);

our @block_procs = ();
our @ready_procs = ();

sub regist {
	my @procs = @_;
	foreach my $p (@_) {
		if ($p -> {status} eq "new") {
			$p -> ready ();
		}
		push @ready_procs, $p;
	}
}

sub _remove {
	my ($index, $list) = (shift, shift);

	if ($index <= $#{$list}) {
		splice @$list, $index, 
					 @$list - $index, 
					 @$list [$index + 1 .. $#{$list}];
	}

}

sub dispatching {

	while (1) {
		for (my $i = 0; $i < @ready_procs; $i ++) {
			# handle interpreter
			my $int_idx = &_random_interrupt ();
			if ($int_idx >= 0) {
				my $class = $block_procs [$int_idx];
				# delete $block_procs [$int_idx];
				&_remove ($int_idx, \@block_procs);
				$class -> ready ();
				push @ready_procs, $class;
			}

			# handle random blocking for current interrupt.
			if (&_random_blocking ()) {
				my $class = $ready_procs [$i];
				push @block_procs, $ready_procs [$i];
				$class -> blocking ();
				# delete $ready_procs [$i];
				&_remove ($i, \@ready_procs);
			} else {
				my $class = $ready_procs [$i];
				$class -> running ();
				# sleep 1;
			}

			sleep 1;

=head
			# handle random blocking
			my $blk_idx = $_random_blocking ();
			if ($blk_idx >= 0) {
				my $class = $ready_procs [$blk_idx];
				delete $ready_procs [$blk_idx];
				push @block_procs, $class;
			}
=cut;

		}

	}

}

sub _random_interrupt {
	my $rand_idx = -1;
	if ((0.5 < rand) && @block_procs) {
		$rand_idx = rand $#block_procs;
	} 
	$rand_idx;
}

sub _random_blocking {
#	my $rand_idx = -1;
#	if ((rand) && @ready_procs) {
#		$rand_idx = rand @#ready_procs;
#	}
#	$rand_idx;
	0.5 < rand;
}


1;

__END__

