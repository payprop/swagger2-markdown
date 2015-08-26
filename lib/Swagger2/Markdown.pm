package Swagger2::Markdown;

=head1 NAME

Swagger2::Markdown - convert a Swagger2 spec to various markdown formats

=for html
<a href='https://travis-ci.org/leejo/swagger2-markdown?branch=master'><img src='https://travis-ci.org/leejo/swagger2-markdown.svg?branch=master' alt='Build Status' /></a>
<a href='https://coveralls.io/r/leejo/swagger2-markdown?branch=master'><img src='https://coveralls.io/repos/leejo/swagger2-markdown/badge.png?branch=master' alt='Coverage Status' /></a>

=head1 VERSION

0.01

=head1 DESCRIPTION

This module allows you to convert a swagger specification file to API Blueprint
markdown (and possibly others).

Note that this module is EXPERIMENTAL and a work in progress. You may also need
to add C<x-> values to your swagger config file to get better markdown output.

=head1 SYNOPSIS

    use strict;
    use warnings;

    use Swagger2;
    use Swagger2::Markdown;

    my $s2md = Swagger2::Markdown->new(
        swagger2 => Swagger2->new->load( $path_to_swagger_spec )
    );

    my $api_blueprint_string = $s2md->api_blueprint;

=cut

use strict;
use warnings;

use Moo;
use Types::Standard qw/ :all /;
use Template;
use Swagger2::Markdown::API::Blueprint;

our $VERSION = '0.01';

=head1 ATTRIBUTES

=head2 swagger2

The L<Swagger2> object, required at instantiation

=cut

has 'swagger2' => (
    is       => 'ro',
    isa      => InstanceOf['Swagger2'],
    required => 1,
);

has '_template' => (
    is       => 'ro',
    isa      => InstanceOf['Template'],
    default  => sub {
        return Template->new({

        });
    },
);

=head1 METHODS

=head2 api_blueprint

Returns a string of markdown in API Blueprint format. Because API Blueprint is more
of a documentation orientated approach there are some sections that it contains that
are not present in the swagger2 spec. Refer to the API Blueprint specification for
the following terms:

    https://github.com/apiaryio/api-blueprint/blob/master/API%20Blueprint%20Specification.md

You should add C<x-api-blueprint> sections to the swagger2 config to define which
format of API Blueprint output you want and to add extra summary and method
documentation. The main layout of the API Blueprint file is defined as so in the top
level of the swagger config file (YAML example here with defaults shown):

    x-api-blueprint:
      resource_section: method_uri
      action_section: method_uri
      attributes: false
      simple: false

Possible values for resource_section are:

    uri             - # <URI template>
    name_uri        - # <identifier> [<URI template>]
    method_uri      - # <HTTP request method> <URI template>
    name_method_uri - # <identifier> [<HTTP request method> <URI template>]

Possible values for action_section are:

    method          - ## <HTTP request method>
    name_method     - ## <identifier> [<HTTP request method>]
    name_method_uri - ## <identifier> [<HTTP request method> <URI template>]
    method_uri      - # <HTTP request method> <URI template>

Possible values for C<attributes> are true and false - if true the Attributes section
will be created in the API Blueprint output.

Possible values for C<simple> are true and false - if true then only the resource
section headers will be printed.

For paths needing extra documentation you can add an C<x-api-blueprint> section to
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

C<summary> and C<description> should be self explanatory, C<group> will make the API
Blueprint output use grouping resources format

You can add examples to the parameters section of a method using C<x-example>:

    paths:
      /messages:
        get:
          parameters:
            - in: query
              ...
              x-example: 3

=cut

sub api_blueprint {
    my ( $self,$args ) = @_;

    my $output;

    $self->_template->process(
        Swagger2::Markdown::API::Blueprint->template,
        {
            f => delete( $self->swagger2->tree->data->{'x-api-blueprint'} ),
            s => $self->swagger2->expand->tree->data,
        },
        \$output,
    ) || die $self->_template->error;

    return $output;
}

=head1 EXAMPLES

See the tests in this distribution - for example t/swagger/foo.yaml will map
to t/markdown.foo.md

=head1 BUGS

Certainly. This has only been tested against the example markdown files on
the API Blueprint github repo, and for that i had to generated the swagger
files by hand.

=head1 AUTHOR

Lee Johnson - C<leejo@cpan.org>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself. If you would like to contribute documentation
please raise an issue / pull request:

    https://github.com/leejo/swagger2-markdown

=cut

__PACKAGE__->meta->make_immutable;

# vim: ts=4:sw=4:et

