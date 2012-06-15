#!/usr/bin/env perl

use warnings;
use strict;

use File::Slurp;

if (@ARGV < 2) {
    die "usage: prepend.pl filename string [strings*]";
}


my $filename = $ARGV[0];

shift @ARGV;
my $prefix = join("\n", @ARGV) . "\n";

write_file( $filename, $prefix, (-e $filename)?read_file( $filename ):undef );

