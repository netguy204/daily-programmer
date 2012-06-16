#!/usr/bin/env perl
#
# Hide things from LZZ that only MOC understands
#

use strict;
use warnings;

if (@ARGV != 1) {
    die "usage: lzz_preproc.pl filename";
}

my $filename = $ARGV[0];
open(my $fh, $filename);
foreach my $line (<$fh>) {
    next if $line =~ /lzz:hide/;
    print $line;
}
close($fh);
