#!/usr/bin/env perl
#
# Find the base include directory for QT
#

use warnings;
use strict;

my $pkgconfig = `pkg-config --cflags QtCore`;

my @args = split(/ /, $pkgconfig);

foreach my $arg (@args) {
    if($arg =~ s/-I(.+)\/include$/$1\/include/) {
        print $arg;
    }
}



