#!/usr/bin/perl

use strict;
use warnings;
use IO::Socket::INET;

my $SERVER_IP;
my $SERVER_PORT;

my $logfd = 'clientlog';
# my $logdir = '/var/log/testserver/';
my $logdir = './';
my $recvbuf = "";

die "Usage command <ip> <port>" 
	if 2 > scalar @ARGV;

# get parameters from input
($SERVER_IP, $SERVER_PORT) = @ARGV;

my $sockfd = new IO::Socket::INET (
		PeerAddr => $SERVER_IP,
		PeerPort => $SERVER_PORT,
		Proto => 'tcp'
		) or
	die "Create Socket error.$!";

open LOG, ">$logdir/$logfd" or
	die "Create file descriptor error!";

my $num = 0;
while (1) {
	send $sockfd, $num, 0;
	print LOG "write to " . $SERVER_IP . " -> $num\n";
	my $sender = recv $sockfd, $recvbuf, 1024, 0;
	chomp $recvbuf;
	if ($sender) {
		print LOG "recv from " . $sender . " -> $recvbuf\n"
	} else {
		print LOG "recv from " . $SERVER_IP . " -> $recvbuf\n";
	}
	$num = $recvbuf;
}

END {
	close $sockfd if $sockfd;
	close LOG;
}

__END__

author : ez
describe : a little client. connect server and transform
     only a digit. And server $digit ++ , push to client.
date : 2016/9/6

