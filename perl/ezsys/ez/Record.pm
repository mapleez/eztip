#!/usr/bin/perl

package ez::Record;

use strict;
use warnings;
use ez::Fileproc;
use Exporter;

use vars qw (@ISA @VERSION @EXPORT @EXPORT_OK);

@ISA = qw (Exporter);
@EXPORT = qw (new gettxtline xp);
@EXPORT_OK = qw (new gettxtline xp); # defaultly exported function.
our @VERSION = "1.0";

# $1 = category
# $2 = money
# $3 = date
# $4 = content
sub new {
	my ($class, $cate, $date, 
			$money, $content) = @_;
	my $this = {
		_cate => $cate,
		_money => $money,
		_content => $content,
		_date => $date
	};
	bless $this, $class;
	$this;
}

sub xp {
	print "tfnasnfljaewv nzjfewa\n";
}

sub gettxtline {
	my $this = shift;
	my ($date, $cate, $money, $content) = 
		(time, &ez::Fileproc::OTHER, 0.0, "Nothing.");
	$date = &_readable_datetime ($$this{_date});
	$cate = $$this{_cate} if $$this{_cate};
	$money = $$this{_money} if $$this{_money};
	$content = $$this{_content} if $$this{_content};
	$cate. " " . $date. " ". $money. " ". "##$content##\n";
}

sub _readable_datetime {
	chomp (my $line = shift);
	if (not defined $line) {
		return "Unknown Date&Time";# if not defined $line;
	} else {
		return scalar (localtime $line);# if defined $line;
	}
}

1;

__END__

