use strict;
use warnings;
use v5.18;
use File::Slurp;

my $msg = "hello attack at dawn";
my $keystream = substr("ninja" x 10, 0, length($msg));

my $out = $keystream ^ $msg;

write_file('output.enc', $out);

