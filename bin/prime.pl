#!/usr/bin/perl

use strict;
use warnings;

use Math::Prime::Simple q/:all/;

my (@ranges, $primes);

@ranges = (  [ 10500, 10600 ],
);
          
$primes = prime(\@ranges);

print <<'EOT';
------
PRIMES
------

EOT

while (my $prime = each_prime(0, $primes)) {
    print "$prime\n";
}

print "\n";
