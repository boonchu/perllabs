#! /usr/bin/env perl

package Person;
use Moose;

has name => ( is => 'rw', isa => 'Str' );

sub hello {
        my $self = shift;
        print "Hello. My name is ", $self->name, "\n";
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;

package main;
use strict;
use warnings;

my $b = new Person(name => "boonchu");
$b->hello;
