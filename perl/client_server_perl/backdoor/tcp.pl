# open_TCP 
# ($file_handle, $dest, $port) return 1 if successful, undef when unsuccessful.
# Input: $fileHandle is the name of the filehandle to use
#        $dest is the name of the destination computer,
#              either IP address or hostname
#        $port is the port number

use Socket;

# configuration variables
my ($_rcvtimeo, $_sndtimeo) = (20, 20);
my $_srv_socket = 0;
my $sin;

# set socket options and connect socket.
sub open_TCP {
  my ($dest, $port) = @_;
  $sin = sockaddr_in ($port, &inet_aton ($dest));
	$proto = getprotobyname ('tcp');
  socket ($_srv_socket, PF_INET, SOCK_STREAM, IPPROTO_TCP)
		or die "Error in creating socket...\n";
# print "$!\n";
# setsockopt $_srv_socket, IPPROTO_TCP, SORCVTIMEO, $_rcvtimeo;
#	setsockopt $_srv_socket, IPPROTO_TCP, SOSNDTIMEO, $_sndtimeo;
	$_srv_socket;
}

sub conn_TCP {
  connect ($_srv_socket, $sin) or return undef;
}

sub asyncread_TCP {
	my ($sock, $buffer, $len) = @_;
	my $nofound = select $sock, undef, undef, $_rcvtimeo;
	return -1 if $nofound == -1; # error
	return -1 unless defined recv ($sock, $$buffer, $len, 0);
	1;
}

sub read_TCP {
	my ($sock, $pbuffer) = @_;
	recv ($sock, $$pbuffer, 1024, 0);
}


sub write_TCP {
	my ($sock, $pbuffer) = @_;
#	my $nofound = select undef, $sock, undef, $_sndtimeo;
#	return -1 if $nofound == -1; # error
	return send ($sock, $$pbuffer, 0);
}

sub close_TCP {
	shutdown (shift, 2);
	print "Closed socket...";
	1;
}


1;
