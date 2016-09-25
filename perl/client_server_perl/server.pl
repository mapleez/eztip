#!/usr/bin/perl

use strict;
use warnings;

use IO::Socket;

# $! = "Error encountered. \n\n Exiting Now ... ";

my $proto = getprotobyname('tcp');
socket (SERV, PF_INET, SOCK_STREAM, $proto) or die $!;

print "\nEnter Host Address : ";
my $host_addr = <STDIN>;
print "Enter Listening Port : ";
my $port_addr = <STDIN>;

my $sockin = sockaddr_in ($port_addr, inet_aton ($host_addr));
bind (SERV,$sockin) || die $!;

my $length = 1024;
listen (SERV, $length) || die $!;

print "\n\nServer is running ....";
print "\nHost Address : $host_addr";
print "Port Address : $port_addr";

accept (FH,SERV) || die $!;
print "A Client Connected...\n\n";

while (1) {
	print "Write your message : ";
	my $buffer = <>;
	my $buff;
	syswrite (FH, $buffer, length ($buffer));
	
	sysread (FH, $buff, 200);  # read at most 200 bytes from FH
	print "Message from client : $buff";
	
}

END {
	close(SERV);
}

