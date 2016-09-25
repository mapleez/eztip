#!/usr/local/bin/perl

use strict;
use warnings;

use Term::Prompt;
require "tcp.pl";

use constant DEFAULT_PORT => 5000; 
use constant DEFAULT_ADDR => '127.0.0.1';

my ($srv_port, $srv_addr);
my $peer_sock = -1;
my $conn_status = 0;
my $cmd_status = 1;

&_get_srv_addr;
&_get_srv_port;

my @cmd_funcs = (
	sub {
		# start
		my ($quit, $input) = (1, '');
		my $rbuff = '';
		return if not defined $srv_addr 
			|| not defined $srv_port;
		print <<EOF
Now start the communication to server $srv_addr:$srv_port
Type your command :
	write/w \$string: write something from socket.
	read/r : read something from socket.
	quit/q : quit this communication, but socket still peer.
EOF
;
		unless ($conn_status) {
			print "You'd better connect to server ". 
				"first. Type connect command.\n";
			return;
		}
		while ($quit) {
			chomp ($input = <>);
			my @split = split //, $input;
			if (2 == scalar @split && $split [0] =~ /^write|w$/i) {
				print "[*] You'd better specify the string to send.\n"
					if length $split [1];
				&write_TCP ($peer_sock, $split [1]);
			} elsif ($split [0] =~ /^read|r$/i) {
				&read_TCP ($peer_sock, \$rbuff);
			} elsif ($split [0] =~ /^quit|q$/i) {
				$quit = 0;
			} else {
				print "Unknown command, type again!\n";
			}
		}
	},
	sub {
		# disconnect
		$conn_status = 0 if &close_TCP;
	},
	sub {
		# connect
		if (&_connect && -1 != $peer_sock) {
			$conn_status = 1;
		}
	},
	sub {
		# set
		&_get_srv_addr;
		&_get_srv_port;
	},
	sub {
		# quit
		$cmd_status = 0;
		print "Bye...\n";
	}
);

#host and port address of server
# print "Enter Host Address to which you want to connect : ";
# chomp (my $loc_host = <>);

# Server port
sub _get_srv_port {
	$srv_port = &prompt ('r', 'Enter server port:', 
			'[1~65535]', &DEFAULT_PORT, 1, 65535);
}

# IP address
sub _get_srv_addr {
	$srv_addr = &prompt ('e', 'Enter server address:',
			'IP address.', &DEFAULT_ADDR, '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}');
}

sub _connect {
	unless (defined ($peer_sock = 
			&open_TCP ($srv_addr, $srv_port))) {
	  print "Error connecting to server: $!\n";
		return undef;
	} else {
	  print "Connected to server \n\n";
		return $peer_sock;
	}
}

# connection to server using open_tcp function in tcp.pl

while ($cmd_status) {

	my @cmds = &prompt ('m',
		{
			prompt => '> ',
			title => 'Command type',
			items => [qw /
				start 
				disconnect 
				connect 
				set
				quit/],
			order => 'across',
			rows => 2,
			cols => 3,
			display_base => 1,
			return_base => 0,
			accept_multiple_selections => 0,
			accept_empty_selections => 0,
			ignore_whitespace => 1,
			separator => '[,/\s]'
		}, 'Type your command',
		'0'
	);

	foreach (@cmds) {
		&{$cmd_funcs [$_]};
	}

}

END {
	close $peer_sock if defined $peer_sock;
	print "Closed socket...\n";
}


