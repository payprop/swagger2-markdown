package Swagger2::Markdown::API::Blueprint;

sub template { return \*DATA }

1;

# vim: ft=tt2;ts=4:sw=4:et

__DATA__
FORMAT: 1A

# [% info.title %]
[% info.description -%]

[% FOREACH path IN paths.keys -%]
    [%- FOREACH method IN paths.$path.keys -%]
# [% method | upper %] [% path -%]
        [%- FOREACH response IN paths.$path.$method.responses.keys %]
+ Response [% response %] [% -%]
            [%- IF paths.$path.$method.produces -%]
                [%- %]([% paths.$path.$method.produces.0 %])
            [%- END %]

        [% paths.$path.$method.responses.$response.examples.values.0 -%]
        [%- END -%]
    [%- END -%]
[%- END -%]
[%# USE Dumper; Dumper.dump( paths ) %]
