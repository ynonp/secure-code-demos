#!/usr/bin/env perl

use strict;
use warnings;
use v5.14;
use File::Slurp;
use Crypt::OpenSSL::RC4;

my $pass = 'zombies';

my $enc = RC4( $pass, "secret message" );
my $zeroes = RC4( $pass, "\x00" x 100 );

write_file( 'm1.enc' , $enc );
write_file( 'zeroes.enc', $zeroes );
write_file( 'xor.enc', $enc ^ $zeroes );

