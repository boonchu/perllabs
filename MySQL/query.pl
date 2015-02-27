#! /usr/bin/env perl
use strict;
use warnings;
use v5.16; # for say() function
use DBI;
 
sub query_web {
	my ($dbh) = @_;
 
  	my $sql = "SELECT title, url, target,tag
             FROM link_tags
             INNER JOIN links ON links.link_id = link_tags.link_id
             INNER JOIN tags  ON tags.tag_id = link_tags.tag_id";
 
  	my $sth = $dbh->prepare($sql);
 
  	$sth->execute();
 
  	while(my $array_ref = $sth->fetchrow_arrayref()){
    		printf("%s\t%s\t%s\t%s\n", $array_ref->[0],
                             $array_ref->[1],
                             $array_ref->[2],
                             $array_ref->[3]);
  	};
  	$sth->finish();
};

say "Perl MySQL Transaction Demo";
 
# MySQL database configurations
my $dsn = "DBI:mysql:database=webdb;host=server1;port=3306";
my $username = "webuser";
my $password = 'app123';
 
# connect to MySQL database
my %attr = (RaiseError=>1,  # error handling enabled
    AutoCommit=>0); # transaction enabled

my $dbh = DBI->connect($dsn,$username,$password, \%attr);

query_web($dbh);
 
# disconnect from the MySQL database
$dbh->disconnect();
