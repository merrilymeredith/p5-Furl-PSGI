package Furl::PSGI;

use warnings;
use strict;

use Furl::PSGI::HTTP;

use parent 'Furl';

sub new {
  my $class = shift;
  bless \(Furl::PSGI::HTTP->new(header_format => Furl::HTTP::HEADERS_AS_HASHREF(), @_)), $class;
}

1;
