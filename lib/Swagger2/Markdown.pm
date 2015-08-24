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
markdown (and possibly others). Note that this module is EXPERIMENTAL and a work
in progress.

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

=head2 api_blueprint

Returns a string of markdown in API Blueprint format

=cut

sub api_blueprint {
    my ( $self ) = @_;

    my $output;

    $self->_template->process(
        Swagger2::Markdown::API::Blueprint->template,
        $self->swagger2->tree->data,
        \$output,
    ) || die $self->_template->error;

    return $output;
}

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

