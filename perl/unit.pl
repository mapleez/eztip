#!/usr/bin/perl

use strict;
use warnings;

use Ezlist;
use Ezqueue;


{
	my $queue = Ezqueue -> new ();
	foreach (1..10) {
		$queue -> push ($_);
	}

	while ($queue -> count ()) {
		print "count=", $queue -> count (), " ";
		print $queue -> pop (), "\n";
		sleep 1;
	}
}

{
	my $list = Ezlist -> new ();
	
	print $list -> getcount (), "\n";
	
	foreach (1..10) {
		$list -> push ($_);
	}
	
	while ($list -> getcount ()) {
		print $list -> getcount (), " ";
		print $list -> pop (), "\n";
		sleep 1;
	}
}

__END__

