#!usr/bin/perl

use strict;
use warnings;
use Net::ARP;

my $mac = Net::ARP::get_mac ("eth0");
print $mac;

$mac = Net::ARP::arp_lookup ('eth0', "10.14.4.167");

Net::ARP::send_packet ('eth0',
						'10.14.4.129', # src
						'10.14.4.166', # target
						'', # src
						'', # target
						'reply'); # type
