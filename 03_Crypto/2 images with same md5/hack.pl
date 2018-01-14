use strict;
use warnings;
use v5.08;


my $first = 0x60;
my $known = 0x68;
my $xor = $first ^ $known;

print $xor, "\n";
