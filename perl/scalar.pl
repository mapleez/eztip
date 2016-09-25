#!/usr/bin/perl

package Scalar;

use strict;
use warnings;
# use eval;
use POSIX;
use Phone;

my $string = 'boobooxpdcboocsdboo';
$string =~ s/boo/mfc/;

# my $string = 'csdn.net, baidu.com, wooyun.com';
# $string = $string =~ m/csdn/;
# print "$`\n$&\n$'\n"
# 	if $string =~ m/,/;

sub sftr {
	print "this is Main::sftr";
}

my $my_phone = Phone -> new ('', '', '');
$my_phone -> sftr ();
# $my_phone->SUPER::sftr ();

# my $hex = 0x0001;
# $hex = unpack ('s>*', $hex);

my ($frame, $res) = (undef, undef); 
my $mxhd = pack ('H4', '0031');
$mxhd = strftime ('%F %T', localtime);

# $frame = pack ('h2' x 12, ('000000000006010300640002'));
$frame = pack ('B*', '00110001'); # = 0x31
$frame = pack ('C' x 13, (0, 1, 0, 2, 0, 6, 1, 3, 4, 0, 0x64, 0, 2));

my 
#	$flag, 
#	$version,
	@count = unpack (
	'SSnCCCnn', 
#'S>*',
			$frame);
# my ($flag, $version,
# 	$length, $deviceid,
# 	$func, $address, 
# 	$count) = unpack ('S4S4n4C2C2n4n4', $frame);

# my $str = '01/28/2001 Flea spray                                24.99';
# 'ABCDEFG';
# my $res = unpack ("H4", $str);
# my ($res, $res2) = unpack ('A10xA27x', $str);
# my $s = pack ("H2" x 10, 30..39);



my $m = undef;
# our $g = 10;
# 
# {
# 	$g = 20;
# 	print $g;
# }

sub xyz {
	my $m = 2013;
	print $m;
}

xyz;


our @arr = (1 .. 20);
for my $x (@arr) {
	print "$x\n";
}

print scalar (@arr); 


# for our $g (1..100) {
# }

# $m += $g;

while (my $line = <>) {
	print ++ $m . $line;
}
continue { # must be executed after each loop
	print $line;
}

my $i;
my @rtn = ();

do {
	@rtn = getpwuid ($i ++);
	foreach (@rtn) {
		print "$_\n";
	}
	print "-" x 10;

} unless (@rtn);

for (10 .. 20) {
	print;
}


my $x = {
	1 .. 20
};

foreach (my ($key, $value) = each ($x)) {
	print "$key, $value\n";
}

# my @files = <*.pl>;
# foreach (@files) {
# 	print;
# }

# my $file = <*.pl>;
# print $file;



=head
my $scalar = 100;

sub get_scalar_str {
	\$scalar;
}

print ${&get_scalar_str};
=cut

# my @stuff = qw(one two three);
# overflow
# my @num = (1 .. 0x7ffffff);
# my $num = "0x" . "ffffffffffffffff" x 10;

# for (my $i = 0; $i < @stuff; $i ++) {
# 	print "$stuff[$i]\n";
# }

# while (my $em = @stuff) {
# 	print "$em \n";
# 	shift @stuff;
# }

# foreach my $em (@stuff) {
# 	print "$em \n";
# }
# 
# print hex ($num) + 1;
# print "\n-----------------------\n";

# my %hash = (1 .. 100);


# local *FILE;
# open FILE, __FILE__;
# my $fd = \*FILE;

# tags;
# my $x = 0;

1;

__END__
