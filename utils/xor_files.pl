#!/usr/bin/env perl
use strict;
use warnings;
use v5.14;
use List::Util qw/reduce/;
use File::Slurp qw/read_file/;

my @files = map { read_file($_) } @ARGV;
print reduce { our $a ^ our $b } @files;

