# $Id: Simple.pm,v 0.05 2004/01/14 22:40:56 sts Exp $

package Math::Prime::Simple;

use 5.006;
use base qw(Exporter);
use integer;
use strict 'vars';
use warnings;

our $VERSION = '0.05';

our @EXPORT_OK = qw(prime each_prime);
our %EXPORT_TAGS = (  all  =>    [ @EXPORT_OK ],
);

sub croak {
    require Carp;
    &Carp::croak;
}

=head1 NAME

Math::Prime::Simple - calculate prime numbers.

=head1 SYNOPSIS

 use Math::Prime::Simple q/:all/;

 @ranges = (    [ 1000, 1100 ],
              [ 10000, 11000 ],
 );

 # primes calculation
 $primes = prime (\@ranges);

 # primes iteration
 while ($prime = each_prime (0, $primes)) {
     print "$prime\n";
 }

=head1 DESCRIPTION

C<Math::Prime::Simple> calculates prime numbers by applying the Sieve of Eratosthenes.

=head1 FUNCTIONS

=head2 prime

Calculates prime numbers.

 @ranges = (   [ 1000, 1100 ],
             [ 10000, 11000 ],
 );

 $primes = prime (\@ranges);

Each range within @ranges will be evaluated and its prime numbers will be
saved within the array ref $primes, accessible by the array index e.g the 
prime numbers of the first range may be accessed by @{$$primes[0]}. 

=cut

sub prime {
    my $data = $_[0];
    croak q~usage: prime (\@ranges)~
      unless @$data && ref $data eq 'ARRAY';
	
    my (%composite, @prime);
    for (my $s = 0; $s < @$data; $s++) {
        for (my $i = 2; $i <= $$data[$s][1]; $i++) {
            next if $composite{$i};
	    my $calc = 0;	
	    for (my $c = 2; $calc <= $$data[$s][1]; $c++)  {
	        $calc = $i * $c;
	        $composite{$calc} = 1;
	    }
	    if ($i > $$data[$s][0]) {
                push @{$prime[$s]}, $i;
            }
        }
    }
    
    return \@prime;
}

=head2 each_prime

Returns each prime number in a scalar context.

 while ($prime = each_prime ($item, $primes)) {
     print "$prime\n";
 }

$item equals the array index of @ranges.

If not all prime numbers are being evaluated by each_prime(), 
it is recommended to undef @{"Math::Prime::Simple::each_prime_$item"}  
after usage of each_prime().

=cut

sub each_prime {
    my ($item, $data) = @_;
    croak q~usage: each_prime ($item, $primes)~
      unless defined $item && ref $data eq 'ARRAY';

    unless (${__PACKAGE__."::each_prime_$item"}) {
        @{__PACKAGE__."::each_prime_$item"} = @{$$data[$item]};
        ${__PACKAGE__."::each_prime_$item"} = 1;
    }

    if (@{__PACKAGE__."::each_prime_$item"}) {
        return shift @{__PACKAGE__."::each_prime_$item"};
    }
    else { ${__PACKAGE__."::each_prime_$item"} = 0; return }
}

1;
__END__

=head1 EXPORT

C<prime(), each_prime()> upon request.

B<TAGS>

C<:all - *()>

=head1 SEE ALSO

perl(1)

=head1 LICENSE

This program is free software; 
you may redistribute it and/or modify it under the same terms as Perl itself.

=head1 AUTHOR

Steven Schubiger

=cut
