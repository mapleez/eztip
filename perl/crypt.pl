#!/usr/bin/perl

use warnings;
use strict;

my ($PWD, $password) = ("nnlafj324jak", "nn");

# while (1) {
my $encryption = crypt $password, $PWD;
print <<END;
\$PWD = $PWD
\$password = $password
\$res = $encryption
---------------------------
END

my $res = crypt "nn", $encryption;
print $res, " ", $encryption, "\n";

#	sleep (1);
# }

__END__
