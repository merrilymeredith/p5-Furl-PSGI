package Furl::PSGI::HTTP;

use warnings;
use strict;

use HTTP::Parser::XS;
use HTTP::Message::PSGI;

use parent 'Furl::HTTP';

sub new {
  my $class = shift;
  my $self  = $class->next::method(@_);

  defined $self->{app}
    or Carp::croak "'app' attribute must be provided";

  $self;
}

sub connect { 1 }

*connect_ssl = *connect_ssl_over_proxy = \&connect;

sub write_all {
  my ($self, $sock, $p, $timeout_at) = @_;
  
  ($self->{request} //= '') .= $p;

  1;
}

sub read_timeout {
  my ($self, $sock, $bufref, $len, $off, $timeout_at) = @_;

  if (my $request = delete $self->{request}) {
    my $env = {};
    my $ret = HTTP::Parser::XS::parse_http_request($request, $env);
    ## TODO handle $ret
    
    my $res = eval { $self->{app}->($env) }
      || $self->_psgi500($@);

    my $response = 
      'HTTP/1.1 ' . HTTP::Message::PSGI::res_from_psgi($res)->as_string("\015\012");

    $$bufref = $response;
    return length($response);
  }

  0;
}

sub _psgi500 {
  my ($self, $e) = @_;
  my $body = "Internal Response: $e";
  [
    500,
    [
      'X-Internal-Response' => 1,
      'Content-Type'        => 'text/plain',
      'Content-Length'      => length($body)
    ],
    [$body]
  ]
}

1;
