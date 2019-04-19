package Furl::PSGI;

# ABSTRACT: Furl, but wired to a PSGI app

use warnings;
use strict;

use Furl::PSGI::HTTP;

use parent 'Furl';

=method new

Supports all options in L<Furl/new>, and additionally requires an C<app>
attribute which should be a L<PSGI> app (a code ref), which will receive ALL
requests handled by the C<Furl::PSGI> instance returned.

=cut

sub new {
  my $class = shift;
  bless \(Furl::PSGI::HTTP->new(header_format => Furl::HTTP::HEADERS_AS_HASHREF(), @_)), $class;
}

1;

__END__
=head1 SYNOPSIS

  use Furl::PSGI;

  my $furl = Furl::PSGI->new(
    app => $my_app,
    # ... any other supported Furl options
  );

  # Request is passed to $my_app and nowhere else
  my $res = $furl->get('https://foo.baz/any/url');

=head1 DESCRIPTION

Furl::PSGI is a subclass of Furl that requires a PSGI app and sends all
requests through that app.  This helps facilitate testing, where you can pass
a Furl::PSGI rather than a Furl and handle any requests in the same process
rather than go out over the network with real requests.

=head1 INHERITANCE

Furl::PSGI
  is a L<Furl>

=head1 WHY

There are already modules that do this for LWP and kin for testing, and those
can sort of drop in for Furl if you're careful how you use them, but it's still
not Furl.  There are slight differences in making requests and dealing with
responses.  I wanted to get a PSGI-connected Furl with no gotchas.

There are also modules like L<Test::TCP> which let you start a process
listening on a free localhost port, but it involves forking a process to run
your PSGI app in, and that can make a mess of test harnesses that don't handle
it.

=head1 SEE ALSO

L<LWP::Protocol::PSGI>, L<Test::WWW::Mechanize::PSGI>

=cut
