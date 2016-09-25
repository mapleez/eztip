#!/usr/bin/perl

use strict;
use warnings;

use IO::Socket;

# $! = "Error encountered. \n\n Exiting Now ... ";

my $proto = getprotobyname('tcp');
socket (SERV, PF_INET, SOCK_STREAM, $proto) or die $!;

# print "\nEnter Host Address : ";
# my $host_addr = <STDIN>;
my $host_addr = "10.14.4.173";
# print "Enter Listening Port : ";
# my $port_addr = <STDIN>;
my $port_addr = 64139;

my $sockin = sockaddr_in ($port_addr, inet_aton ($host_addr));
bind (SERV,$sockin) || die $!;

my $length = 1024;
listen (SERV, $length) || die $!;

print "\n\nServer is running ....";
print "\nHost Address : $host_addr ";
print "Port Address : $port_addr\n";

my $incomming = accept (FH,SERV) 
	|| die $!;
my ($iport, $iaddr) = &sockaddr_in ($incomming);
$iaddr = gethostbyaddr ($iaddr, AF_INET);
print "A Client Connected($iaddr:$iport)...\n\n";

while (1) {
	print "Write your message : ";
	my $buffer = <>;
	if (ord ($buffer) == 10) {
		$buffer = "<EMPTY>";
	}
	my $buff;
	my $slen = send (FH, $buffer, length ($buffer), 0);
	recv (FH, $buff, 1024, 0);  # read at most 200 bytes from FH
	print "Message from client : $buff\n";
}

END {
	close(SERV);
}

__END__

# author : ez
# Describe : my Server
# Date : 2016/5/29
