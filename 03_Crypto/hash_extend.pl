use strict;
use warnings;
use v5.14;
use Scalar::Util qw/looks_like_number/;

my ( $secret, $data, $fake_data ) = @ARGV;
$fake_data ||= '';

my $filler = 56 - ( looks_like_number($secret) ? $secret : length($secret) ) 
                - length($data);

my $length = 8 * ( 56 - $filler );

if ( ! looks_like_number($secret) ) {
  print $secret;
}

print $data .
      "\x80" . "\x0" x ( $filler - 1 ) . pack("q", $length);

if ( $fake_data ) {
  print $fake_data;
}
