#! /usr/bin/env perl 

use strict;
use warnings;

sub fix {
    local $_ = shift;
    my ($white, $leader);  # common whitespace and common leading string
    if (/^\s*(?:([^\w\s]+)(\s*).*\n)(?:\s*\g1\g2?.*\n)+$/) {
        ($white, $leader) = ($2, quotemeta($1));
    } else {
        ($white, $leader) = (/^(\s+)/, '');
    }
    s/^\s*?$leader(?:$white)?//gm;
    return $_;
}

my $poem = fix<<EVER_ON_AND_ON;
   Now far ahead the Road has gone,
  And I must follow, if I can,
   Pursuing it with eager feet,
  Until it joins some larger way
   Where many paths and errands meet.
  And whither then? I cannot say.
    --Bilbo in /usr/src/perl/pp_ctl.c
EVER_ON_AND_ON

print $poem;
