#!/usr/bin/env perl

use autodie;
use strict;
use warnings;
use POSIX qw/ceil/;

my $USAGE = "$0 <byte_as_hex_string> ... ";

@ARGV > 0 or die $USAGE;

foreach my $h_byte (@ARGV) {
  my $parsed = parse_byte_string( $h_byte );
  print pack( "H16" , $parsed );
}

sub parse_byte_string {
  my ( $byte_as_hex_string ) = @_;

  if ( $byte_as_hex_string =~ /^0x(?:00)*(.*)/ ) {
    $byte_as_hex_string = $1;
  }

  my @nibbles = unpack("a2" x length($byte_as_hex_string), $byte_as_hex_string );
  $byte_as_hex_string = join('', reverse(@nibbles));

  return $byte_as_hex_string;
}



