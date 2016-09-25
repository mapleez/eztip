#!/usr/bin/perl

package ez::Fileproc;

use strict;
use warnings;
use Exporter;
use ez::Record;
use vars qw (@ISA $VERSION @EXPORT @EXPORT_OK);

# category
use constant EATTING => 0;
use constant WEARING => 1;
use constant SAILING => 2;
use constant TRAVEL => 3;
use constant OTHER => 4; 

@ISA = qw (Exporter);
@EXPORT = @EXPORT_OK;
@EXPORT_OK = qw (write_accounting read_accounting); # defaultly exported function.
our $VERSION = "1.0";

# configuration data.
my $FILEDIR = "/ezpriv/hack/work/git/perl_study/ezsys/datas/";
my @FILES = qw (
		eatting wearing
		sailing travel
		others
);

# map filename to category.
sub _map_name {
	chomp (my $fname = shift);
	if ($fname) {
		my $idx = 0;
		foreach (@FILES) { 
			return $idx 
				if $_ eq $fname; 
			$idx ++; 
		}
	}
	return OTHER;
}

# methods.
sub _write_line {
	my ($cate, $line) = @_;
	my $fd = undef;
	open $fd, ">>", "$FILEDIR/$FILES[$cate]"
		or die "Error in opening $FILEDIR/$FILES[$cate]\n";
	print $fd $line; # write data.
	close $fd;
	return 1;
}

# $1 = money
# $2 = category
# $3 = content
sub write_accounting {
	my ($money, $cate, $content) = @_;
	if (defined $cate) {
		my $cate_num = &_map_name ($cate);
		my $line = $cate_num." ".time." ".$money.
			"##". $content. "##\n";
		&_write_line ($cate_num, $line);
		return $line;
	} else {
		return undef;
	}
}

sub _load_accounting {
	my ($cate, $fd) = (shift, undef);
	if (defined $FILES[$cate] and -e "$FILEDIR/$FILES[$cate]") {
		open $fd, "<", "$FILEDIR/$FILES[$cate]"
			or die "Error in opening $FILES[$cate]:$!\n";
 		# load all into memory, maybe it's 
		# not a good way.
		return my @lines = <$fd>;
	}
	return undef;
}

# get file name array.
sub read_accounting {
	my @cate = @_;
	my @res = (); # array of Record class.
	if (@cate) {
		foreach my $c (@cate) {
			my $ctnum = &_map_name ($c);
			my @lines = &_load_accounting ($ctnum);
			map { 
				my $rcd = &_read_line ($_); # records.
				push (@res, $rcd) if defined $rcd;
			} @lines if @lines;
		}
	} else {
		print "Error in read accounting.\n";
	}
	@res;
}

# create new Record class with line.
# $1 = record string.
sub _read_line {
	my $line = shift;
	my $rcd = undef;
	if ($line and $line =~ /(\d*)\s*(\d*)\s*(-?\d+\.?\d*)##(.*)##/) {
		$rcd = new ez::Record ($1, $2, $3, $4);
	}
	$rcd;
}

1;
__END__

