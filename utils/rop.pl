#!/usr/bin/env perl

use strict;
use warnings;
use File::Slurp qw/read_file/;

my $USAGE = <<END;
  $0 <rop_combo> <length>
END

my $rop_file        = shift or die $USAGE;
my $required_length = shift or die $USAGE;

my $shellcode = read_file( $rop_file );

my $padding = "0" x $required_length;

print $padding, $shellcode;



