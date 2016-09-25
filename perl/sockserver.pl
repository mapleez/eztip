#!/usr/bin/perl

use strict;
use warnings;
use IO::Socket::INET;

my $SERVER_IP;
my $SERVER_PORT;

my $logfd = 'srvlog';
# my $logdir = '/var/log/testserver/';
my $logdir = "./";
my $recvbuf = "";
my $clientsock = 0;

die "Usage command <ip> <port>" 
	if 2 > scalar @ARGV;

# get parameters from input
($SERVER_IP, $SERVER_PORT) = @ARGV;

my $sockfd = new IO::Socket::INET (
		LocalAddr => $SERVER_IP,
		LocalPort => $SERVER_PORT,
		Proto => 'tcp',
		Listen => 10
		) or
	die "Create Socket error.";

open LOG, ">$logdir/$logfd" or
	die "Create file descriptor error!";

$sockfd ->listen()
 or die "listen : $!\n";
print "Start listen...\n";

$clientsock = $sockfd ->accept()
 or die "accept : $!\n";
print "Accepted!\n";

my $num = 0;
while (1) {
	my $sender = recv $clientsock, $recvbuf, 1024, 0;
	chomp $recvbuf;
	if ($sender) {
		print LOG "recv from " . $sender . " -> $recvbuf\n"
	} else {
		print LOG "recv from " . $SERVER_IP . " -> $recvbuf\n";
	}

	$num = ++ $recvbuf;
	send $clientsock, $num, 0;
	print LOG "write to " . $SERVER_IP . " -> $num\n";

}

END {
	close $sockfd if $sockfd;
	close $clientsock if $clientsock;
	close LOG;
}

__END__

author : ez
describe : a little client. connect server and transform
     only a digit. And server $digit ++ , push to client.
date : 2016/9/6

