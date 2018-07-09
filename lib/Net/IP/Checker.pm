#ABSTRACT: IPv4/IPv6 addresses validator

=head1 NAME

Net::IP::Checker

=head1 DESCRIPTION

Fork of Net::IP::Minimal that validate IPv4 and IPv6 addresses correctly

=head1 SYNOPSIS

  use Net::IP::Checker qw[:ALL];
  
  my $ip = '172.16.0.216';
  ip_is_ipv4( $ip ) and print "$ip is IPv4";

  $ip = 'dead:beef:89ab:cdef:0123:4567:89ab:cdef';
  ip_is_ipv6( $ip ) and print "$ip is IPv6";

  print ip_get_version( $ip );

=head1 SEE ALSO

L<Net::IP>, L<Net::IP::Checker>, L<Net::IP::Lite>

=cut

package Net::IP::Checker;

use strict;
use warnings;
use Regexp::IPv6 qw($IPv6_re);
use Regexp::IPv4 qw($IPv4_re);

require Exporter;

our @ISA = qw(Exporter);
our @EXPORT_OK = qw(ip_get_version ip_is_ipv4 ip_is_ipv6);
our %EXPORT_TAGS = ( 'ALL' => [ @EXPORT_OK ] );

=head1 FUNCTIONS

The same as L<Net::IP> these functions are not exported by default. You may import them explicitly
or use C<:PROC> to import them all.

=over

=item C<ip_get_version>

Try to guess the IP version of an IP address.

    Params  : IP address
    Returns : 4, 6, undef(unable to determine)
    
=cut

sub ip_get_version {
    my $ip = shift;
    $ip !~ /:/ and ip_is_ipv4($ip) and return '4';
    ip_is_ipv6($ip) and return '6';
    return;
}

=item C<ip_is_ipv4>

Check if an IP address is of type 4.

    Params  : IP address
    Returns : 1 (yes) or 0 (no)
    
=cut

sub ip_is_ipv4 {
    my $ip = shift;
    return $ip =~ /^$IPv4_re$/ ? 1 : 0
}


=item C<ip_is_ipv6>

Check if an IP address is of type 6.

    Params            : IP address
    Returns           : 1 (yes) or 0 (no)
    
=cut

sub ip_is_ipv6 {
    my $ip = shift;
    return $ip =~ /^$IPv6_re$/ ? 1 : 0
}
