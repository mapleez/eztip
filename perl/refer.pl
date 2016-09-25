#!/usr/bin/perl

use strict;
use warnings;

# $a = "refer.pl";

# print "Can do.\n" if -r $a || -w _ || -x _;

# stat ($a);
print "Readable\n" if -r _;
print "Writeable\n" if -w _;
print "Executable\n" if -x _;
print "Setuid\n" if -u _;
print "Setgid\n" if -g _;
print "Sticky\n" if -k _;
print "Text\n" if -T _;
print "Binary\n" if -B _;

# sub _a_func {
# 	my $x = __FILE__ . __LINE__;
# 	print "$x\n";
# }

my %func = ( 
	'a' => sub {
		my $string = $_ [0] || 'none to print';
		print "$string\n";
	} 
# 	'a' => sub {
# 		print "this is a function...";
# 	}
# 	'b' => sub {
# 		print "this is b function...";
# 	},
# 	'c' => sub {
# 		print "this is c function...";
# 	},
# 	'd' => sub {
# 		print "this is d function...";
# 	}
);


&{$func {'a'}} ();

my %hash = {
	a => 'fasdfljdas',
	b => 'fdaf'
};

# my $func_ref = $func {a};
# &$func_ref ();

my $x = $hash{a};
print $x;

# my @val = values %func;
# my @key = keys %func;
# 
# foreach (@val) {
# 	print "$_\n"
# }

my $x = qw(fsaf fdsa xx eeqz fdwcd d) [0];
print $x;

my @keys = qw(perls c# c++ c java);
my %hash;
@hash{@keys} = ("m") x @keys;
foreach (keys %hash) {
	print $hash {$_}. "\n";
}
# @hash {@keys};

print join '.', @keys;

print "-" x 20, "\n";

my $array_ref = [
 qw(perls c# c++ c java)
];

print @$array_ref[0], " ";

foreach (@$array_ref) {
	print $_. "\n";
}



