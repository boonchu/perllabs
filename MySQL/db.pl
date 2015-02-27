#! /usr/bin/env perl
use strict;
use warnings;
use v5.16; # for say() function
 
use DBI;
 
say "Perl MySQL Transaction Demo";
 
# MySQL database configurations
my $dsn = "DBI:mysql:database=webdb;host=server1;port=3306";
my $username = "webuser";
my $password = 'app123';
 
# connect to MySQL database
my %attr = (RaiseError=>1,  # error handling enabled
    AutoCommit=>0); # transaction enabled
 
my $dbh = DBI->connect($dsn,$username,$password, \%attr);
 
eval{
# insert a new link
my $sql = "INSERT INTO links(title,url,target)
   VALUES(?,?,?)";
my $sth = $dbh->prepare($sql);
$sth->execute("Comprehensive Perl Archive Network","http://www.cpan.org/","_blank");
# get last insert id of the link
my $link_id = $dbh->{q{mysql_insertid}};
 
# insert a new tag
$sql = "INSERT INTO tags(tag) VALUES(?)";
$sth = $dbh->prepare($sql);
$sth->execute('Perl');
 
# get last insert id of the tag
my $tag_id = $dbh->{q{mysql_insertid}};
 
# insert a new link and tag relationship
$sql = "INSERT INTO link_tags(link_id,tag_id)
VALUES(?,?)";
$sth = $dbh->prepare($sql);
$sth->execute($link_id,$tag_id);
 
# if everything is OK, commit to the database
$dbh->commit();
say "Link and tag has been inserted and associated successfully!";
};
 
if($@){
say "Error inserting the link and tag: $@";
$dbh->rollback();
}
 
# disconnect from the MySQL database
$dbh->disconnect();
