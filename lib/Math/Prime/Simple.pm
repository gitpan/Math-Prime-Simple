package Math::Prime::Simple;

$VERSION = '0.09';
@EXPORT_OK = qw(prime each_prime);

use strict 'vars';
use integer;
use base qw(Exporter);
use Carp 'croak';

=head1 NAME

Math::Prime::Simple - Calculate prime numbers

=head1 SYNOPSIS

 use Math::Prime::Simple qw(prime each_prime);

 @ranges = (    [ 1000, 1100 ],
              [ 10000, 11000 ],
 );

 # primes calculation
 $primes = prime( \@ranges );

 # primes iteration
 while ($prime = each_prime( 0, $primes )) {
     print "$prime\n";
 }

=head1 DESCRIPTION

Math::Prime::Simple calculates prime numbers by applying the Sieve of Eratosthenes.

=head1 FUNCTIONS

=head2 prime

Calculates prime numbers.

 @ranges = (   [ 1000, 1100 ],
             [ 10000, 11000 ],
 );

 $primes = prime( \@ranges );

Each range within @ranges will be evaluated and its prime numbers will be
saved within the arrayref $primes, accessible by the array index; the 
prime numbers of the first range may be accessed by @{$primes->[0]}. 

=cut

sub prime {
    my ($ranges) = @_;
    croak 'usage: prime( \@ranges )' unless @$ranges;
    	
    my (%composite, @primes);
    
    for (my $s = 0; $s < @$ranges; $s++) {
        for (my $i = 2; $i <= $ranges->[$s][1]; $i++) {
            next if $composite{$i};
	    
	    my $calc = 0;	
	    for (my $c = 2; $calc <= $ranges->[$s][1]; $c++)  {
	        $calc = $i * $c;
	        $composite{$calc} = 1;
	    }
	    
	    if ($i > $ranges->[$s][0]) {
                push @{$primes[$s]}, $i;
            }
        }
    }    
    
    return \@primes;
}

=head2 each_prime

Returns each prime number as string.

 while ($prime = each_prime( $index, $primes )) {
     print "$prime\n";
 }

$index equals the array index of @ranges.

If not all prime numbers are being evaluated by each_prime(), 
it is recommended to undef @{"Math::Prime::Simple::each_prime_$index"}  
after usage of each_prime().

=cut

sub each_prime {
    my ($index, $primes) = @_;
    croak 'usage: each_prime( $index, $primes )'
      unless (defined $index && @$primes);
      
    my $PRIMES = __PACKAGE__."::_each_prime_$index";
          
    unless (${$PRIMES}) {
        @{$PRIMES} = @{$primes->[$index]};
        ${$PRIMES} = 1;
    }
        
    if (@{$PRIMES}) {
        return shift @{$PRIMES};
    }
    else { 
        ${$PRIMES} = 0; 
	
	return undef;
    }
}

1;
__END__

=head1 EXPORT

C<prime(), each_prime()> are exportable.

=cut
