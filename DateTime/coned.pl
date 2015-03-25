#! /usr/bin/env perl

package main;

use strict;
use warnings;
use DateTime;

my $argv = shift;
my $dt = DateTime->from_epoch( epoch => $argv );
print "$dt->day\/$dt->month\/$dt->year $dt->hour\:$dt->minute\n";

1;
