#!/usr/bin/env perl

use warnings;
use strict;

use List::MoreUtils 'any';

if (@ARGV != 2) {
    die "usage: lzz_deps.pl filename outfile";
}

my $filename = $ARGV[0];
my $outfile = $ARGV[1];

# get the name of all of our lzzs
my @lzzs = glob('*.lzz');
foreach (@lzzs) {
    s/\.lzz$/\.h/g;
}

# find any cases where they're included
my @includes = ();
open(my $fh, $filename);

my $disabled = 0;
foreach my $line (<$fh>) {
    if(!$disabled && $line =~ s/#include "([^"]+)"$/$1/) {
        chomp($line);
        foreach my $lzz (@lzzs) {
            if ($line eq $lzz) {
                push @includes, $line;
            }
        }
    } elsif($line =~ /#src$/) {
        $disabled = 1;
    } elsif($line =~ /#end$/) {
        $disabled = 0;
    }
}

close($fh);

open(my $of, ">$outfile");
$filename =~ s/\.lzz$/\.h/g;

if(@includes) {
    print $of "$filename $outfile : " . join(' ', @includes) . "\n";
}
close($of);

