#! /usr/bin/perl

use strict;
use warnings;
use Math::Prime::Simple qw(prime each_prime);

my @ranges = ([ 10500, 10600 ]);         
my $primes = prime( @ranges );

print <<'EOT';
------
primes
------

EOT

while (my $prime = each_prime( 0, $primes )) {
    print "$prime\n";
}
