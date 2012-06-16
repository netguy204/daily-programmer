#!/usr/bin/env perl
#
# Find sentinal expressions designed to be passed through by lzz and
# replace them with their intended counterparts (that, for some
# reason, lzz finds offensive.)

use strict;
use warnings;

if (@ARGV != 1) {
    die "usage: lzz_inline.pl filename";
}

my $filename = $ARGV[0];
my @lines = ();

open(my $fh, $filename);
foreach my $line (<$fh>) {
    $line =~ s/virtual lzz_inline_([^\ ]+).*$/$1/;
    push @lines, $line;
}
close($fh);

open(my $of, ">$filename");
print $of join("\n", @lines);
close($of);
