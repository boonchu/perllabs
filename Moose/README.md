###### Perl Moose

Moose is perl object oriented programming libraries. 

###### Install
```
$ sudo yum install perl-Moose
```
###### Basic of object attributes such as get or set, etc.
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
###### Basic of Constructor (how to contructs object, class attributes, etc)
```
sub BUILD {
        my ($self) = @_;

        if ($self->name eq 'boonchu') {
                confess 'Boonchu is not allowed for using Person class';
        }
        return;
}
```
###### Basic of Immutable

###### Pattern 1: Delegation
* perl support delegation that allow code to handle data structures like object. 
```
has 'mapping' => (
        traits  => ['Hash'],
        is      => 'rw',
        isa     => 'HashRef[Str]',
        default => sub { {} },
        handles => {
                exists_in_mapping => 'exists',
                ids_in_mapping    => 'keys',
                get_mapping       => 'get',
                set_mapping       => 'set',
                set_quantity      => [ set => 'quantity' ],
      },
);
```
###### Pattern 2: Singleton

###### Pattern 3: Adapter

###### Pattern 4: Proxy

* Reference
- [Moose part I](http://www.stonehenge.com/merlyn/LinuxMag/col94.html)
- [Moose part II](http://www.stonehenge.com/merlyn/LinuxMag/col95.html)
- [Moose Cookbook](http://search.cpan.org/~ether/Moose-2.1403/lib/Moose/Cookbook.pod)
