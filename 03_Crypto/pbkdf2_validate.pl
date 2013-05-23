use strict;
use warnings;
use v5.14;
use Crypt::PBKDF2;

my $pbkdf2 = Crypt::PBKDF2->new();

my $guess = shift;
my $db_password = <>;

if ( $pbkdf2->validate( $db_password, $guess ) ) {
  say "Welcome";
} else {
  say "Intruder";
}
