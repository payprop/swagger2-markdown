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

$Template::Stash::LIST_OPS->{ path_and_query_params } = sub {
    my $list = shift;
    my $params = [ grep { $_->{in} =~ /path|query/ } @$list ];
    return @{ $params } ? $params : undef;
};

$Template::Stash::LIST_OPS->{ none_path_and_query_params } = sub {
    my $list = shift;
    my $params = [ grep { $_->{in} !~ /path|query/ } @$list ];
    return @{ $params } ? $params : undef;
};

$Template::Stash::HASH_OPS->{ sort_methods_by_group } = sub {
    my $hash = shift;

    return sort {
        ( $hash->{$a}{"x-api-blueprint"}{group} // '' )
            cmp ( $hash->{$b}{"x-api-blueprint"}{group} // '' )
        || $a cmp $b
    } keys %{ $hash };
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

[%- BLOCK response_section -%]
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
            [%- body_padding = '    ' -%]
        [%- ELSE -%]
            [%- body_padding = '' -%]
        [%- END -%]
        [%- IF s.paths.$path.$method.responses.$response.schema -%]
            [%- "\n\n        " _ body_padding; s.paths.$path.$method.responses.$response.schema.example  _ "\n\n" -%]
        [%- ELSE -%]
            [%- "\n" -%]
        [%- END -%]
    [%- END -%]
[%- END -%]

[%- BLOCK request_section -%]
    [%- IF s.paths.$path.$method.parameters.none_path_and_query_params -%]
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
        [%- FOREACH param IN s.paths.$path.$method.parameters -%]
            [%- IF param.schema -%]
                [%- "\n\n        " -%]
                [%- param.schema.example; "\n" -%]
                [%- LAST -%]
            [%- END -%]
        [%- END -%]
    [%- END -%]
[%- END -%]

[%- BLOCK method_section -%]
    [%- FOREACH method IN s.paths.$path.sort_methods_by_group -%]
        [%- IF method == api_blueprint; NEXT; END -%]
        [%- summary = s.paths.$path.$method.summary -%]
        [%- PROCESS action_section -%]
        [%- IF s.paths.$path.$method.description.defined -%]
            [%- s.paths.$path.$method.description -%]
        [%- END -%]
        [%- FOREACH param IN s.paths.$path.$method.parameters.path_and_query_params -%]
            [%- IF loop.first; "\n+ Parameters\n\n"; END -%]
            [%- example = 'x-example' -%]
            [%- %]    + [% param.name %]: [% param.$example %] ([% param.type %][% IF NOT param.required; ', optional'; END %]) - [% param.description %][% "\n" -%]
            [%- IF param.default.defined -%]
            [%- %]        + Default: `[% param.default %]`[% "\n" -%]
            [%- END -%]
        [%- END -%]
        [%- PROCESS request_section -%]
        [%- PROCESS response_section -%]
    [%- END -%]
[%- END -%]
FORMAT: 1A

# [% s.info.title %]
[% s.info.description -%]

[% FOREACH path IN s.paths.keys.sort -%]
    [%- api_blueprint = 'x-api-blueprint' -%]
    [%- IF s.paths.$path.$api_blueprint.defined -%]
        [%- summary = s.paths.$path.$api_blueprint.summary -%]
        [%- group = s.paths.$path.$api_blueprint.group -%]
        [%- IF group -%]
            [%- "\n" IF NOT loop.first -%]
            [%- IF group != s.paths.${ loop.prev }.$api_blueprint.group -%]
                [%- "# Group " _ group _ "\n" -%]
                [%- s.paths.$path.$api_blueprint.description -%]
                [%- IF s.paths.$path.keys.size == 1; NEXT; ELSE; "\n"; END -%]
            [%- END -%]
        [%- END -%]
    [%- END -%]
    [%- PROCESS resource_section -%]
    [%- IF s.paths.$path.$api_blueprint.defined -%]
        [%- IF group -%]
            [%- s.paths.$path.$api_blueprint.group_description _ "\n" -%]
        [%- ELSE -%]
            [%- s.paths.$path.$api_blueprint.description _ "\n" -%]
        [%- END -%]
    [%- END -%]
    [%- PROCESS method_section -%]
[%- END -%]
[%-# USE Dumper; Dumper.dump( s.paths ) -%]
EndOfBlueprint

}
