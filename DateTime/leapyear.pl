#! /usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;

sub _is_leap_year($) {
	my $year = shift;

	# print $year, "\n";
	my $var1 = (($year % 4) == 0) ? 1 : 0;
	my $var2 = (($year % 100) != 0) ? 1 : 0;
	my $var3 = (($year % 400) == 0) ? 1 : 0;
	# print "[", $var1, "] [" , $var2, "] [", $var3, "]\n";

	return eval($var1 and ( $var2 or $var3 ));
}

sub _num_of_days($$) {
	my ($month, $year) = @_;
	my @days = ( 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 );
	if ( $month == 1 and _is_leap_year( $year )) {
		return 29;
	};
	return $days[ $month - 1];
}

#print Dumper _is_leap_year( 2000 );
#print Dumper _num_of_days(1, 2000);

package main;

use Time::Piece;

my $date = <STDIN>;
my $time = Time::Piece->strptime($date);

print " [ ",$time->mon," ] , [ ",$time->mday," ] [ ",$time->year," ] \n";

my $output = 0;
for (my $i = 1; $i <= $time->mon; $i++) {
	$output += _num_of_days($i, $time->year);
}

print $output;
