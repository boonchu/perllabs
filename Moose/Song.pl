#! /usr/bin/env perl

package Song;
use Moose;

has filename => ( is => 'rw', isa => 'Str' );

no Moose;
__PACKAGE__->meta->make_immutable;

1;

package Song::MP3;
use Moose;
extends 'Song';

has path => ( is => 'ro', isa => 'Str' );
has content => ( is => 'ro', isa => 'Str' );
has last_mod_time => ( is => 'ro', isa => 'Str' );

sub print_info {
	my $self = shift;
	print "This filename is " , $self->filename, "\n";
	print "This file is at " , $self->path, "\n";
	print "This content is ", $self->content, "\n";
}

sub set_filename {
	my $self = shift;
	eval {
		$self->filename = shift;
	}; die('immutable error at filename!') if $@;
}

sub set_path {
	my $self = shift;
	eval {
		$self->path = shift;
	}; die('immutable error at path!') if $@;
}

no Moose;

1;

package main;

use strict;
use warnings;
use Song::MP3;

my $pod = Song::MP3->new(
		filename => 'cookie.mp3',
		path => '/tmp',
		content => 'hello world',
	);
$pod->print_info;

$pod->set_filename('hello.mp3');
$pod->print_info;

$pod->set_path('/etc');
$pod->print_info;

1;

__END__
