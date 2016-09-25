#!/usr/bin/perl

# author : ez
# date : 2015/12/22
# describe : a simple round-robin dispatcher for os.

package Ezdispatcher;

use strict;
use warnings;
use Exporter;

use vars qw (@ISA @proc_list @EXPORT @EXPORT_OK);

@ISA = qw (Exporter);
@EXPORT = @EXPORT_OK;
@EXPORT_OK = qw (dispatching);
our @proc_list = ();

sub dispatching  {

	# round-robin
	while (1) {
		foreach my $p (@proc_list) {
			print "running process \"",
				"$p->{img}\" for 1000ms\n";
			$p -> _start2 ();
			sleep 1;
			print "dispatching.";
			$p -> _stop2 ();
		}
	}

}


1;

__END__
