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
my @h_includes = ();
my @c_includes = ();

open(my $fh, $filename);

my $src_includes = 0;
foreach my $line (<$fh>) {
    if($line =~ s/#include "([^"]+)"$/$1/) {
        chomp($line);
        foreach my $lzz (@lzzs) {
            if ($line eq $lzz) {
                if($src_includes) {
                    push @c_includes, $line;
                } else {
                    push @h_includes, $line;
                }
            }
        }
    } elsif($line =~ /#src$/) {
        $src_includes = 1;
    } elsif($line =~ /#end$/) {
        $src_includes = 0;
    }
}

close($fh);

open(my $of, ">$outfile");

my $h_filename = $filename;
$h_filename =~ s/\.lzz$/\.h/;

my $c_filename = $filename;
$c_filename =~ s/\.lzz$/\.cpp/;

if(@h_includes) {
    print $of "$h_filename $outfile : " . join(' ', @h_includes) . "\n";
}

if(@c_includes) {
    print $of "$c_filename $outfile : " . join(' ', @c_includes) . "\n";
}

close($of);

