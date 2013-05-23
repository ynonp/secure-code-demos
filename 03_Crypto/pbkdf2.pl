use strict;
use warnings;
use v5.14;
use Crypt::PBKDF2;

my ( $password ) = shift || 'letmein';

my $saltlen = shift || 4;
my $pbk = Crypt::PBKDF2->new(
  hash_class => 'HMACSHA2',
  iterations => 1000,
  output_len => 20,
  salt_len   => $saltlen,
);

print $pbk->generate( $password );
