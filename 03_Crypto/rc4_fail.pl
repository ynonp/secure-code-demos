#!/usr/bin/env perl

use strict;
use warnings;
use v5.14;
use File::Slurp;
use Crypt::OpenSSL::RC4;

my $pass = 'zombies';

my $enc    = RC4( 'IV1' . $pass, "secret message" );
my $zeroes = RC4( 'IV2' . $pass, "\x00" x 100 );

my $dec = RC4('IV1' . $pass, $enc);


write_file( 'm1.enc' , $enc );
write_file( 'zeroes.enc', $zeroes );
write_file( 'xor.enc', $enc ^ $zeroes );

