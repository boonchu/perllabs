#! /usr/bin/env perl

use Data::LinkedList;
use Data::Dumper;

my $obj1 = Data::LinkedList->new( data => 'abc' );
my $obj2 = Data::LinkedList->new( data => 'baker', next => $obj1);

print Dumper $obj2;
