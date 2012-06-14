#!/usr/bin/env perl

use warnings;
use strict;

use File::Slurp;

if (@ARGV != 2) {
    die "usage: prepend.pl filename string";
}


my $filename = $ARGV[0];
my $prefix = $ARGV[1];

write_file( $filename, $prefix, (-e $filename)?read_file( $filename ):undef );

