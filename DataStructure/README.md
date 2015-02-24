###### Perl Data Structure
* start with Linked List. I dumped all objects from linked list. 
  * [why do we still bother linked list](http://www.slideshare.net/lembark/perly-linked-lists)?
```
$ ./ll.t
$VAR1 = bless( {
                 'data' => 'baker',
                 'next' => bless( {
                                    'data' => 'abc'
                                  }, 'Data::LinkedList' )
               }, 'Data::LinkedList' );
```
