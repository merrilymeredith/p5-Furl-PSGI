# NAME

Furl::PSGI - Furl, but wired to a PSGI app

# VERSION

version 0.01

# SYNOPSIS

    use Furl::PSGI;

    my $furl = Furl::PSGI->new(
      app => $my_app,
      # ... any other supported Furl options
    );

    # Request is passed to $my_app and nowhere else
    my $res = $furl->get('https://foo.baz/any/url');

# DESCRIPTION

Furl::PSGI is a subclass of Furl that requires a PSGI app and sends all
requests through that app.  This helps facilitate testing, where you can pass
a Furl::PSGI rather than a Furl and handle any requests in the same process
rather than go out over the network with real requests.

# METHODS

## new

Supports all options in ["new" in Furl](https://metacpan.org/pod/Furl#new), and additionally requires an `app`
attribute which should be a [PSGI](https://metacpan.org/pod/PSGI) app (a code ref), which will receive ALL
requests handled by the `Furl::PSGI` instance returned.

# INHERITANCE

Furl::PSGI
  is a [Furl](https://metacpan.org/pod/Furl)

# WHY

There are already modules that do this for LWP and kin for testing, and those
can sort of drop in for Furl if you're careful how you use them, but it's still
not Furl.  There are slight differences in making requests and dealing with
responses.  I wanted to get a PSGI-connected Furl with no gotchas.

There are also modules like [Test::TCP](https://metacpan.org/pod/Test::TCP) which let you start a process
listening on a free localhost port, but it involves forking a process to run
your PSGI app in, and that can make a mess of test harnesses that don't handle
it.

# SEE ALSO

[LWP::Protocol::PSGI](https://metacpan.org/pod/LWP::Protocol::PSGI), [Test::WWW::Mechanize::PSGI](https://metacpan.org/pod/Test::WWW::Mechanize::PSGI)

# AUTHOR

Meredith Howard <mhoward@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2019 by Meredith Howard.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
