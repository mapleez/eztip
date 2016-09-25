#!/usr/bin/perl

# author : ez
# date : 2016/3/3
# describe : This programming used for my 
#      accounting recording.

use strict;
use warnings;
use ez::Fileproc;
use Getopt::Args qw(opt arg optargs usage);
use ez::Statistic;
use Switch qw (switch case);

our $VERSION = 'v1.1';

# -h --help
opt help => (
	isa => 'Bool',
	comment => 'Print help string.',
	alias => 'h',
	ishelp => 1
);

# -s --statistic
opt statistic => (
	isa => 'Bool',
	comment => 'Count all records and print result.',
	alias => 's'
);

# -c --category
opt cate => (
	isa => 'Str',
	comment => "Specified the category of accounting record.",
	alias => 'c'
);

# -t --time 
opt time => (
	isa => 'Str',
	comment => 'Specified the date for action.',
	alias => 't'
);

# -p --pattern
opt pattern => (
	isa => 'Str',
	comment => 'Specified a pattern and search record matched by comment. with format : category,money, enclosed by parenthese.',
	alias => 'p'
);

# -C --comment
opt comment => (
	isa => 'Str',
	comment => 'Specified comment for adding record.',
	alias => 'C'
);

arg action => (
	isa => 'Str',
	comment => <<EOF

    - add : Add a new record into file or database.
    - list : list record, with specified date range.
    - remove : remove records with specified date range. or a given date.
EOF
);

# enclosed with "".
arg params => (
	isa => 'Str',
	comment => 'The parameters for action',
);


my $options = &optargs ();
my ($help, $comment, $category, 
		$time, $pattern, $statistic, 
		$action, $params) = (
	$options -> {'help'}, $options -> {'comment'}, 
	$options -> {'cate'}, $options -> {'time'}, 
	$options -> {'pattern'}, $options -> {'statistic'}, 
	$options -> {'action'}, $options -> {'params'});

die &usage () if defined $help;
if (defined $statistic) {
	&_statistic ();
	exit (0);
}

if (defined $action) {
	switch ($action) {
		case "add" { 
			my $money = $params;
			if ($category && $money && 
					$money =~ /^-?\d+\.?\d*$/) {
				my $line = &ez::Fileproc::write_accounting ($money, $category, 
						defined $comment ? $comment : 'None');
				print "Add record : $line";
			} else {
				die <<EOF
You'd better input your cost as PARAMS, and 
type the record category with option -c(--cate). 
Category can be eatting, wearing, sailing, 
traveling and other.
EOF
					;
			}
		}
	
		case "list" { 
			if (defined $category) {
				my @records = &ez::Fileproc::read_accounting (split /,/, $category);
				foreach my $rcd (@records) {
					print $rcd -> gettxtline ();
				}
			}
		}
	
		case "remove" { 
			print "you use remove command.$params\n";
		}
	
	  else { die &usage (); }	
	};
} else {
	die &usage ();
}


sub _statistic {
	my %hash = &ez::Statistic::count_day (
			&ez::Fileproc::read_accounting ("eatting", "wearing",
				"sailing", "others", "travel"));
	die "Error in counting records *o*!!! Maybe there is no record." 
		unless %hash;
	while (my ($k, $v) = each %hash) {
		print <<EOF
* $k cost:  
eatting  wearing  sailing  travel  other  total
$$v[0]   $$v[1]   $$v[2]   $$v[3]  $$v[4]  $$v[5]

EOF
;
	}
}


# testing ...
# &Fileproc::write_accounting (23.5, &Fileproc::WEARING, "my car gas.");
# &Fileproc::write_accounting (23.5, &Fileproc::WEARING, "my car gas.");
# &Fileproc::write_accounting (23.5, &Fileproc::WEARING, "my car gas.");
# map { print $_-> gettxtline (); }
# 	&Fileproc::read_accounting (&Fileproc::WEARING);

# my @lines = &Fileproc::load_accounting (1);
# 
# foreach (@lines) {
# 	print $_;
# }


__END__

