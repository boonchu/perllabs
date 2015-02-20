###### Perl Moose

Moose is perl object oriented programming libraries. 

* ####### Basic of object attributes such as get or set, etc.
* Getter
```
packge Person;
use Moose;

has name, is => 'ro';
```
* Setter with string validation
```
pacakge Person;
use Moose;

has name, is => 'rw', isa => 'Str';
```
* Object behavior implementation
```
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

my $p = new Person(name => "boonchu");
$p->hello;
```
* Constructor (how to contructs object, class attributes, etc)

* Delegation

* Singleton

* Decorating

* Prototype


