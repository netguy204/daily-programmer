#!/usr/bin/env perl

use warnings;
use strict;

my @lzzs = glob('*.lzz');

foreach my $lzz (@lzzs) {
    $lzz =~ s/\.lzz$//g;
    print "class $lzz;\n";
}

