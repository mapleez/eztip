#!/usr/bin/perl

# AUTHOR : ez
# DATE : 2015/10/31
# DESCRIBE : program in learning Perl 6th.
#    chapter 6

use warnings;
use strict;

# chapter 6

# program 1

my %table = ( 
	fred => "flintstone",
	barney => "rubble",
	wilma => "flintstone"
	);

sub get_family_by_name {

	chomp (my $name = <>);
	print $table{$name} ?
		$table {$name} : "no record";

}

# &get_family_by_name;


# program 2
sub count_words {
	my %word_count = ();
	while (<>) {
		chomp;
		next if //;
		$word_count {$_} += 1; 
	}

	foreach my $line (keys %word_count) {
		print $line, "=>", $word_count{$line}, "\n";
	}
}

# &count_words;

__END__
