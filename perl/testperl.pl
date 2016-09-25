#!/usr/bin/perl

# --------------------------
# author : ez
# date : 2015/8/23
# describe : test perl script
# --------------------------

use strict;
use warnings;
use Phone;

# my $rand_var = rand;
# print $rand_var, "\n";

# my $rand_var = rand (1);
# print $rand_var, "\n";
my @list_ptr = (1..20);
sub remove {
	my ($index, $list) = (shift, shift);
	if ($index <= $#{$list}) {
		splice @$list, $index, @$list - $index, @$list [$index + 1 .. $#{$list}];
# @$list [$index .. $#{$list} - 1] = @$list [$index + 1 .. $#{$list}];
#		splice @$list, $#{$list} - 1, 1;
	}
}

&remove (2, \@list_ptr);
# delete $list_ptr[2];

=head some simple operation
sub main () {
	my $phrase = "Howdy, world!\n";
	my $interpolation = "this is interpolation string = $phrase";
	my $nointerpolation = 'this is no interpolation string = $phrase';

	my $sub = sub { print "this is sub sub!"; };
	my $ptr_phrase = \$phrase;
	my $ptr_array = [1 .. 100];
	my $ptr_hash = {name => $ptr_array, string => $phrase};

	print $phrase;
	print $interpolation;
	print $nointerpolation;

	&$sub;
	print $$ptr_phrase. "\n";
	print @$ptr_array. "\n";
	print %$ptr_hash. "\n";
}


sub plurality {
	my @home = ("couch", "chair", "table", "stove");
	my ($potato, $lift, $tennis, $pipe) = @home;
	print @home, $potato, $lift, $tennis, $pipe. "\n";

	my %hash = (
		thu => "thursday",
		mon => "monday",
		wed => "wednesday",
		tue => "tuesday",
		fri => "friday",
		sat => "Saturday",
		sun => "Sunday"
		);

	print "get the value of key (thu):". $hash {thu}. "\n";
	print %hash;
	# get keys array;
	print keys %hash;
	# get values array;
	print values %hash;

	print "\n-----------------\n";
	my %language;
	$language {"ez"} = [qw/java c c++ perl python html SQL css/];
	print $language {"ez"} [0]." ". $language {"ez"} [1];

	print "\n-----------------\n";
	my %kids_of_wife;
	$kids_of_wife {"jacob"} = {
		leah => ['reuben', 'simeon', 'levi', 'judah', 'issachar', 'zebulun'],
		rachel => ['joseph', 'benjamin'],
		bilhah => ['dan', 'Naphtali'],
		zilpah => ['gad', 'asher']
	};
	print $kids_of_wife {"jacob"} {"leah"} [0], $kids_of_wife {"jacob"} {"rachel"} [1];
	print "\n-----------------\n";
}



sub other () {

#   my $ref0 = {arr => []};
# 	push $ref0 -> {'arr'}, 'ref0';
# 
# 	my $ref1 = {arr => undef};
# 	push $ref1 -> {'arr'}, 'ref1';
# 	print scalar ($ref0 -> {'arr'})." ". scalar ($ref1 -> {'arr'});

	my $x = [1, 2, 3, 4];
	my $m = "xfdasfa";
	print ref $x;	

}

# P36
sub _P36 {
	my %grades;
	open GRADES, "grades"
		or die "Cannot open file grades: $!\n";
	while (my $line = <GRADES>) {
		my ($student, $grade) = split " ", $line;
		$grades {$student} .= $grade . " ";
	}

	foreach my $student (sort keys %grades) {
		my $scores = 0;
		my $total = 0;

		my @grades = split " ", $grades {$student};
		foreach my $grade (@grades) {
			$total += $grade;
			$scores ++;
		}

		my $average = $total / $scores;
		print "$student: $grades{$student}\etAverage: $average\n";
	}

}
=cut

=head
print STDOUT "enter a number:";
my $number = <STDIN>;
print STDOUT "The number is $number.\n";
=cut

# while (@ARGV) {
# 	print shift @ARGV;
# }


# _P36 ();

=head
open FILE, "testperl.pl" 
	or die "error in opening $ARGV[0]\n";

my $i = 0;
while (<FILE>) {
	$i ++;
	next if /^#/ or /^\t+#/;
	print "$i $_"; 
}
close FILE;
=cut

# print hostname ();

# &other ;
# &plurality;

=head
my @foo = (1 .. 100);
my $foo = $#foo + 1;
open foo, "<testperl.pl" or die "connot open file...";

print $foo [-1], $foo;
while (<foo>) {
	print unless /^#/ or /^\t+#/
}

close foo;
=cut

=head indirection
my $scalar = 100;

sub get_scalar_str {
	\$scalar;
}

print ${&get_scalar_str};
=cut

my $temp = join ($", @ARGV);
print $temp;
print "@ARGV";

my $val = "377";
$val = oct ($val);

$val = "011";
$val = hex ($val);

$val = "hex = \x64, oct = \064";
$val = "\ucode \Uchina \Q32ac,.?\E\n";
$val = q/'I think this "story" may be interesting'.../;

my $func = qq{
	if (istrue) {
		print q/this may be true/;
	}
};

$func = qq/
	if (isfalse) {
		print $val;
	}
/;

print $val =~ s/t/M/;

# my $phone = Phone -> new ('iphone 4s', '4800', 'white');
# $phone -> display ();

=head hear-document
print << x 10;
abcdefghijklmnopqrstuvwxyz

print <<"" x 10;
abcdefghijklmnopqrstuvwxyz

print <<`EXEC`;
echo hello there
echo hello fuck
EXEC

print <<"shit", <<"fuck";
fsdfsf
shit
fjdksnf
fuck

# my ($quote = <<'QUOTE') =~ s/^\s+//gm;
# 	funcfdasnflasd
# 	fds
# fsda
# fdskj
# QUOTE

my $quote;
($quote = <<'QUOTE') =~ s/^\s+//gm;
	funcfdasnflasd
	fds
fsda
fdskj
QUOTE

print $quote;
=cut

=head function ref
my $statement = sub {
	my ($start, $end, @arr) = @_;
	foreach (@arr) {
		$start += $_ + $end;
	}
	$start;
};

print $statement;
print &$statement (10, 20, (50 .. 80));
=cut

my %hash_func = (
		a => sub {
			print "this is A function...";
		},
		b => sub {
			print "this is B function...";
		}
);

my $func_name = "a";
&{$hash_func {$func_name}} ();

my $hash_calc = %hash_func;

$val = v102.111.111;
print $val;
print "\x30\x31\x32";

print __FILE__;

# while (<DATA>) {
# 	print;
# }

__END__

__DATA__
