# vim: ft=perl

requires 'Furl', '3.02';
requires 'Plack', '1.0032';
requires 'HTTP::Parser::XS', '0.11';

on test => sub {
  requires 'Test::Simple', '0.96';
};

