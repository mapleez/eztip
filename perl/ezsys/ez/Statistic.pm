#!/usr/bin/perl

package ez::Statistic;
use strict;
use warnings;

use strict;
use warnings;
use Exporter;
use ez::Fileproc;
use vars qw (@ISA $VERSION @EXPORT @EXPORT_OK);

@ISA = qw (Exporter);
@EXPORT = @EXPORT_OK;
@EXPORT_OK = qw (count_day); # defaultly exported function.


# return format:
#   (eatting, wearing, sailing, travel, other, total)
sub count_day {
	my @rcds = @_; 
	my %res = ();
	if (@rcds) {
		my $key;
		map {
			$key = &_date2hashkey ($_ -> {_date});
			$res {$key} = [] if (! exists $res {$key});
			push @{$res {$key}}, $_;
		} @rcds;
		# retrive
		while (my ($k, $v) = each %res) {
			my ($eatting, $wearing, $sailing, $travel, $other, $total) = 
				(0, 0, 0, 0, 0, 0);
			map {
				if ($_ -> {_cate} == &ez::Fileproc::EATTING) {
					$eatting += $_ -> {_money};
					$total += $_ -> {_money};
				} elsif ($_ -> {_cate} == &ez::Fileproc::WEARING) {
					$wearing += $_ -> {_money};
					$total += $_ -> {_money};
				} elsif ($_ -> {_cate} == &ez::Fileproc::SAILING) {
					$sailing += $_ -> {_money};
					$total += $_ -> {_money};
				} elsif ($_ -> {_cate} == &ez::Fileproc::TRAVEL) {
					$travel += $_ -> {_money};
					$total += $_ -> {_money};
				} else {
					$other += $_ -> {_money};
					$total += $_ -> {_money};
				}
			} @$v;
			$res {$key} = [$eatting, $wearing, 
				$sailing, $travel, $other, $total];
		}
	}
	return %res;
}

sub _date2hashkey {
	my $date = shift;
	my ($sec, $min, $hour, $mday, $mon, $year, @remain) = 
		localtime ($date);
	$year."/".$mon."/".$mday;
}

1;
__END__

