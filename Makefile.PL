#!perl

use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
    MIN_PERL_VERSION => '5.10.1',
    NAME          => 'Swagger2::Markdown',
    ABSTRACT_FROM => 'lib/Swagger2/Markdown.pm',
    VERSION_FROM  => 'lib/Swagger2/Markdown.pm',
    AUTHOR        => 'Lee Johnson <leejo@cpan.org>',
    LICENSE       => 'perl',
    PREREQ_PM => {
        'Moo'             => '2.000001',
        'Types::Standard' => '1.000005',
        'Template'        => '2.26',
    },
    BUILD_REQUIRES => {
        'Swagger2'              => '0.49',
        'File::Find'            => '0',
        'File::Spec::Functions' => '0',
        'File::Slurper'         => '0.006',
        'Test::More'            => '0',
        'Test::LongString'      => '0.17',
        'YAML::XS'              => '0.59',
    },
    META_MERGE => {
        resources => {
            license    => 'http://dev.perl.org/licenses/',
            homepage   => 'https://metacpan.org/module/Swagger2::Markdown',
            bugtracker => 'https://github.com/leejo/swagger2-markdown/issues',
            repository => 'https://github.com/leejo/swagger2-markdown'
        },
    },
    test => {
        TESTS => 't/*.t',
    },
);

# vim: ts=4:sw=4:et
