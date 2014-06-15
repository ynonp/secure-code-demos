#!/usr/bin/env perl

my $x = 10;
my $text = "Hello World\n";

$buf = get_from_external_input();

if ( $buf =~ /[.]txt$/ ) {
  open FIN, $buf;
  while(<FIN>) { }
  close FIN;
}

my $buf = "names.secret\x00.txt";

print $buf, "\n";

