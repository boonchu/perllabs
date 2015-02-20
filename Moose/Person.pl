#! /usr/bin/env perl

package Person;
use Moose;
use Carp qw( confess );

has name => ( is => 'rw', isa => 'Str' );
has age  => ( is => 'rw', isa => 'Num' );

sub BUILD {
	my ($self) = @_;

	if ($self->name eq 'boonchu') {
		confess 'Boonchu is not allowed for using Person class';
	}
	return;
}

sub hello {
        my $self = shift;
        print "Hello. My name is ", $self->name, ". I am about ", $self->age, " year old\n";
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;

package main;
use strict;
use warnings;
use v5.16;

my $a = new Person(name => "alex", age => 25);
my $b = new Person(name => "boonchu", age => 40);
$a->hello;
$b->hello;
