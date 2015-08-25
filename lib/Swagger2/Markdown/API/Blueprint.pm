package Swagger2::Markdown::API::Blueprint;

use strict;
use warnings;

use Template::Stash;

# define list method to return new list of odd numbers only
$Template::Stash::LIST_OPS->{ request_headers } = sub {
    my $list = shift;
    my $headers = [ grep { $_->{in} eq 'header' } @$list ];
    return @{ $headers } ? $headers : undef;
};

sub template {
    my ( $args ) = @_;

    my $template = _blueprint();
    return \$template;
}

1;

# vim: ft=tt2;ts=4:sw=4:et

sub _blueprint {

    return << 'EndOfBlueprint';
[%- BLOCK resource_section -%]
    [%- IF group; prefix = '##'; ELSE; prefix = '#'; END -%]
    [%- SWITCH f.resource_section -%]
        [%- CASE 'uri' -%]
[% prefix %] [% path _ "\n" -%]
        [%- CASE 'name_uri' -%]
[% prefix %] [% summary %] [[% path -%]][% "\n" -%]
        [%- CASE 'method_uri' -%]
[% prefix %] [% method | upper %] [% path -%][% "\n" -%]
        [%- CASE 'name_method_uri' -%]
[% prefix %] [% summary %] [[% method | upper %] [% path -%]][% "\n" -%]
        [%- CASE -%]
[% IF method.defined %]# [% method | upper %] [% path %][% END -%]
    [%- END -%]
[%- END -%]

[%- BLOCK action_section -%]
    [%- IF group; prefix = '###'; ELSE; prefix = '##'; END -%]
    [%- SWITCH f.action_section -%]
        [%- CASE 'method' -%]
[% prefix %] [% method | upper; "\n" -%]
        [%- CASE 'name_method' -%]
[% prefix %] [% summary %] [[% method | upper -%]][% "\n" -%]
        [%- CASE 'name_method_uri' -%]
[% prefix %] [% summary %] [[% method | upper %] [% path %]][% "\n" -%]
        [%- CASE -%]
[% IF method.defined %]# [% method | upper %] [% path %][% END -%]
    [%- END -%]
[%- END -%]
FORMAT: 1A

# [% s.info.title %]
[% s.info.description -%]

[% FOREACH path IN s.paths.keys.sort -%]
    [%- description_key = 'x-api-blueprint' -%]
    [%- IF s.paths.$path.$description_key.defined -%]
        [%- summary = s.paths.$path.$description_key.summary -%]
        [%- group = s.paths.$path.$description_key.group -%]
        [%- IF group -%]
            [%- "\n" IF NOT loop.first -%]
            [%- "# Group " _ group _ "\n" -%]
            [%- s.paths.$path.$description_key.description -%]
            [%- IF s.paths.$path.keys.size == 1; NEXT; ELSE; "\n"; END -%]
        [%- END -%]
    [%- END -%]
    [%- PROCESS resource_section -%]
    [%- IF s.paths.$path.$description_key.defined -%]
        [%- IF group -%]
            [%- "\n" -%]
        [%- ELSE -%]
            [%- s.paths.$path.$description_key.description _ "\n" -%]
        [%- END -%]
    [%- END -%]
    [%- FOREACH method IN s.paths.$path.keys.sort -%]
        [%- IF method == description_key; NEXT; END -%]
        [%- summary = s.paths.$path.$method.summary -%]
            [%- PROCESS action_section -%]
        [%- IF s.paths.$path.$method.description.defined -%]
            [%- s.paths.$path.$method.description -%]
        [%- END -%]
        [%- IF s.paths.$path.$method.parameters.defined -%]
            [%- "\n+ Request " -%]
            [%- IF s.paths.$path.$method.consumes -%]
                [%- %]([% s.paths.$path.$method.consumes.0 %])
                [%- IF s.paths.$path.$method.parameters.request_headers -%]
                    [%- "\n\n    + Headers" -%]
                    [%- FOREACH header IN s.paths.$path.$method.parameters.request_headers -%]
                        [%- "\n\n" %]            [% header.name %]: [% header.type %][% "\n" -%]
                    [%- END -%]
                [%- END -%]
            [%- END %]
            [%- IF s.paths.$path.$method.parameters.0.schema; "\n\n" -%]
        [% s.paths.$path.$method.parameters.0.schema.example; "\n" -%]
            [%- END -%]
        [%- END -%]
        [%- FOREACH response IN s.paths.$path.$method.responses.keys.sort -%]
            [%- "\n+ Response " _ response -%]
            [%- IF s.paths.$path.$method.produces -%]
                [%- %] ([% s.paths.$path.$method.produces.0 %])
            [%- END %]
            [%- IF s.paths.$path.$method.responses.$response.headers -%]
                [%- "\n\n    + Headers\n" -%]
                [%- FOREACH header IN s.paths.$path.$method.responses.$response.headers.keys.sort -%]
            [%- "\n            " _ header %]: [% s.paths.$path.$method.responses.$response.headers.$header.type; "\n\n" -%]
                [%- END -%]
            [%- "    + Body" -%]
            [%- body_padding = '    '; END -%]
            [%- IF s.paths.$path.$method.responses.$response.schema -%]
                [%- "\n\n        " _ body_padding; s.paths.$path.$method.responses.$response.schema.example  _ "\n\n" -%]
            [%- ELSE -%]
            [%- "\n" -%]
        [%- END -%]
        [%- END -%]
    [%- END -%]
[%- END -%]
[%-# USE Dumper; Dumper.dump( s.paths ) -%]
EndOfBlueprint

}
