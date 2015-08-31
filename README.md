# NAME

Swagger2::Markdown - convert a Swagger2 spec to various markdown formats

<div>

    <a href='https://travis-ci.org/leejo/swagger2-markdown?branch=master'><img src='https://travis-ci.org/leejo/swagger2-markdown.svg?branch=master' alt='Build Status' /></a>
    <a href='https://coveralls.io/r/leejo/swagger2-markdown?branch=master'><img src='https://coveralls.io/repos/leejo/swagger2-markdown/badge.png?branch=master' alt='Coverage Status' /></a>
</div>

# VERSION

0.03

# DESCRIPTION

This module allows you to convert a swagger specification file to API Blueprint
markdown (and possibly others).

Note that this module is EXPERIMENTAL and a work in progress. You may also need
to add `x-` values to your swagger config file to get better markdown output.

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

# METHODS

## api\_blueprint

Returns a string of markdown in API Blueprint format. Because API Blueprint is more
of a documentation orientated approach there are some sections that it contains that
are not present in the swagger2 spec. Refer to the API Blueprint specification for
the following terms: [https://github.com/apiaryio/api-blueprint/blob/master/API%20Blueprint%20Specification.md](https://github.com/apiaryio/api-blueprint/blob/master/API%20Blueprint%20Specification.md)

You should add `x-api-blueprint` sections to the swagger2 config to define which
format of API Blueprint output you want and to add extra summary and method
documentation. The main layout of the API Blueprint file is defined as so in the top
level of the swagger config file (YAML example here with defaults shown):

    x-api-blueprint:
      resource_section: method_uri
      action_section: method_uri
      attributes: false
      simple: false
      data_structures: false

Possible values for resource\_section are:

    uri             - # <URI template>
    name_uri        - # <identifier> [<URI template>]
    method_uri      - # <HTTP request method> <URI template>
    name_method_uri - # <identifier> [<HTTP request method> <URI template>]

Possible values for action\_section are:

    method          - ## <HTTP request method>
    name_method     - ## <identifier> [<HTTP request method>]
    name_method_uri - ## <identifier> [<HTTP request method> <URI template>]
    method_uri      - # <HTTP request method> <URI template>

Possible values for `attributes` are true and false - if true the Attributes
sections will be created in the API Blueprint output.

Possible values for `simple` are true and false - if true then only the resource
section headers will be printed.

Possible values for `data_structures` are true and false - if true then only a
Data Structures section will be output to show definitions, and those request or
response parameters that reference those (using `$ref`) will also reference the
Data Structures section.

For paths needing extra documentation you can add an `x-api-blueprint` section to
the path like so (again, YAML example here):

    paths:
      /message:
        x-api-blueprint:
          group: Messages
          summary: My Message
          description: |
            The description that will appear under the group section
          group_description: |
            The description that will appear under the resource_section header

`summary` and `description` should be self explanatory, `group` will make the API
Blueprint output use grouping resources format

You can add examples to the parameters section of a method using `x-example`:

    paths:
      /messages:
        get:
          parameters:
            - in: query
              ...
              x-example: 3

# EXAMPLES

See the tests in this distribution - for example t/swagger/foo.yaml will map
to t/markdown.foo.md

# BUGS

Certainly. This has only been tested against the example markdown files on
the API Blueprint github repo, and for that i had to generate the swagger
files by hand.

# AUTHOR

Lee Johnson - `leejo@cpan.org`

# LICENSE

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself. If you would like to contribute documentation
please raise an issue / pull request:

    https://github.com/leejo/swagger2-markdown
