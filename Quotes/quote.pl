#! /usr/bin/env perl 

use strict;
use warnings;

(my $QUOTE = <<EOF) =~ s/^\s+//gm;
	m...we will have peace, when you and all your works have
	perished--and the works of your dark master to whom you
	would deliver us. You are a liar, Saruman, and a corrupter
	of men's hearts. --Theoden in /usr/src/perl/taint.c 
EOF

$QUOTE =~ s/\s+--/\n--/;

print $QUOTE;
