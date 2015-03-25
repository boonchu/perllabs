#! /usr/bin/env perl

use strict;
use warnings;

sub compare_arrays($$) {
    my ($first, $second) = @_;
    no warnings;  # silence spurious -w undef complaints
    return 0 unless @$first == @$second;
    for (my $i = 0; $i < @$first; $i++) {
        return 0 if $first->[$i] ne $second->[$i];
    }
    return 1;
}

my @frogs = ( '1', '2', '3' );
my @toads = ( 'a', 'b', 'c' );

my $are_equal = compare_arrays(\@frogs, \@toads);
if ( $are_equal > 0 ) {
	print "equal\n";
} else {
	print "not equal\n";
}
