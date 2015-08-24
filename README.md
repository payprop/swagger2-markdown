# NAME

Swagger2::Markdown - convert a Swagger2 spec to various markdown formats

<div>

    <a href='https://travis-ci.org/leejo/swagger2-markdown?branch=master'><img src='https://travis-ci.org/leejo/swagger2-markdown.svg?branch=master' alt='Build Status' /></a>
    <a href='https://coveralls.io/r/leejo/swagger2-markdown?branch=master'><img src='https://coveralls.io/repos/leejo/swagger2-markdown/badge.png?branch=master' alt='Coverage Status' /></a>
</div>

# VERSION

0.01

# DESCRIPTION

This module allows you to convert a swagger specification file to API Blueprint
markdown (and possibly others). Note that this module is EXPERIMENTAL and a work
in progress.

# SYNOPSIS

    use strict;
    use warnings;

    use Swagger2;
    use Swagger2::Markdown;

    my $s2md = Swagger2::Markdown->new(
        swagger2 => Swagger2->new->load( $path_to_swagger_spec )
    );

    my $api_blueprint_string = $s2md->api_blueprint;

# ATTRIBUTES

## swagger2

The [Swagger2](https://metacpan.org/pod/Swagger2) object, required at instantiation

## api\_blueprint

Returns a string of markdown in API Blueprint format

# AUTHOR

Lee Johnson - `leejo@cpan.org`

# LICENSE

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself. If you would like to contribute documentation
please raise an issue / pull request:

    https://github.com/leejo/swagger2-markdown
