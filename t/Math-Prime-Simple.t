#! /usr/local/bin/perl

use strict;
use warnings;
use Math::Prime::Simple qw(prime each_prime);

use Test::More tests => 4;

BEGIN {
    my $PACKAGE = 'Math::Prime::Simple';
    use_ok( $PACKAGE );
    require_ok( $PACKAGE );
}

my @ranges = ([ 10500, 10600 ]);
my $primes = prime( @ranges );

is( $primes->[0][-2], 10589, 'prime( @ranges ); ');
is( each_prime( 0, $primes ), 10501, 'each_prime( $index, $primes ); ');
