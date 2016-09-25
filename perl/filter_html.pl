#!/usr/bin/perl

# -------------------------------
# author : ez
# date : 2015/8/23
# describe : this script send 
#		 http request for a http 
#        url and filter some 
#		 special tag you input
# -------------------------------

use strict;
use warnings;
use LWP::UserAgent;
use Data::Dumper;
use HTML::TreeBuilder;
use Getopt::Args;

our $VERSION = 'v1.0';

arg url => (
		required => 1,
		isa => 'Str',
		comment => 'Host address, maybe domain name, or ip.',
);

opt tags => (
	alias => 't',
	isa => 'Str',
	default => 'a,script,img',
	comment => 'specify the html tags to find, separated by comma.',
);


opt help => (
    isa => 'Bool',
	comment => 'Print help string.',
	alias => 'h',
	ishelp => 1
);

# opt port => (
# 	isa => 'Int',
# 	alias => 'p',
# 	comment => 'http server tcp port. default as 80. this version support only img, a, script.',
# 	default => 80 
# );


my %disp_func = ( 
	a => sub {
		my $em = shift;
		return if ! defined ($em) and $em -> tag () ne 'a';
		my $href = $em -> attr ('href');
		print "a url = "
			. ($href ? $href : 'none') . "\n";
	},
	script => sub {
		my $em = shift;
		return if ! defined ($em) and $em -> tag () ne 'script';
		my $type = $em -> attr ('type');
		my $src = $em -> attr ('src');
		print "script type = "
			. ($type ? $type : '') . ", src = "
			. ($src ? $src : '') . "\n";
	},
	img => sub {
		my $em = shift;
		return if ! defined ($em) and $em -> tag () ne 'img';
		my $src = $em -> attr ('src');
		print "img src = "
			. ($src ? $src : '') . "\n";
	}
);

my ($port, $url, $tags) = ();

{
# initialize parameters
	my $options = optargs ();
	$port = ($options -> {'port'})
		? $options -> {'port'} : 80;

	$tags = ($options -> {'tags'})
		? $options -> {'tags'} : 'img,script,a';

	die usage unless $options -> {'url'};
	$url = ($options -> {'url'});
}


my @tags = split /,/, $tags;
my ($useragent, $request,
	$html, $tree,
	$html_tag) = ();

$useragent = LWP::UserAgent -> new;
$request = HTTP::Request -> new ('GET' => $url);

$request -> content_type ('application/x-www-form-urlencoded');
$request -> header ('Accept-Language' => 'zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0.3');

print "[-] sending request to $url ...\n";
$html = $useragent -> request ($request);
print "[-] get response !\n";

$tree = new HTML::TreeBuilder;
$tree -> parse ($html -> content ());
$tree -> eof ();

$html_tag = $tree -> elementify ();
# my @decendants = $html_tag -> descendants ();

# maybe the parameter could be more exciting  :-)
my @find_tags = $html_tag -> find_by_tag_name ('img', 'a');

foreach (@find_tags) {
	next if !defined ($_) and $_ -> tag () eq '';
	&{$disp_func {$_ -> tag ()}} ($_);
}

$tree -> delete ();

__END__
