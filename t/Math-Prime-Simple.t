#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 4;

use Math::Prime::Simple qw(prime each_prime);

my (@ranges, $primes, $prime);

BEGIN {
    my $PACKAGE = 'Math::Prime::Simple';
    use_ok($PACKAGE);
    require_ok($PACKAGE);
}

@ranges = (  [ 10500, 10600 ],
);

$primes = prime(\@ranges);
is($$primes[0][-2], '10589', 'prime (\@ranges);');
is(each_prime(0, $primes), '10501', 'each_prime ($item, $primes);');
