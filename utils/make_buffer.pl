#!/usr/bin/env perl

use autodie;
use strict;
use warnings;
use POSIX qw/ceil/;

my $USAGE = "$0 <pad_length> <byte_as_hex_string> ... ";

my $length = shift or die $USAGE;

print "0" x ( $length + 8 );

foreach my $h_byte (reverse @ARGV) {
  my $parsed = parse_byte_string( $h_byte );
  print pack( "H8" , $parsed );
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



