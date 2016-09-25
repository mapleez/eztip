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

# set socket options and connect socket.
sub open_TCP {
  my ($dest, $port) = @_;
  my $sin = &sockaddr_in ($port, &inet_aton ($dest));

  socket ($_srv_socket, PF_INET, SOCK_STREAM, IPPROTO_TCP);
	setsockopt $_srv_socket, IPPROTO_TCP, SORCVTIMEO, $_rcvtimeo;
	setsockopt $_srv_socket, IPPROTO_TCP, SOSNDTIMEO, $_sndtimeo;
  connect ($_srv_socket, $sin) or return undef;

#  my $old_fh = select ($FS);
#  $| = 1; 		        # don't buffer output
#  select ($old_fh);
	$_srv_socket;
}

sub read_TCP {
	my ($sock, $buffer, $len) = @_;
	my $nofound = select $sock, undef, undef, $_rcvtimeo;
	return -1 if $nofound == -1; # error
	return -1 unless defined recv ($sock, $$buffer, $len, 0);
	1;
}


sub write_TCP {
	my ($sock, $buffer, $len) = @_;
	my $nofound = select undef, $sock, undef, $_sndtimeo;
	return -1 if $nofound == -1; # error
	return send ($sock, $$buffer, 0);
}

sub close_TCP {
	close $_;
	print "Closed socket...";
	1;
}


1;
