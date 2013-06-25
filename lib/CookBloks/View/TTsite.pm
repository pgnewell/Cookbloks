package CookBloks::View::TTsite;

use strict;
use base 'Catalyst::View::TT';

__PACKAGE__->config({
    TEMPLATE_EXTENSION => '.tt2',
    INCLUDE_PATH => [
        CookBloks->path_to( 'root' ),
        CookBloks->path_to( 'root', 'src' ),
        CookBloks->path_to( 'root', 'lib' )
    ],
    PRE_PROCESS  => 'config/main',
    WRAPPER      => 'site/wrapper',
    ERROR        => 'error.tt2',
    TIMER        => 0,
    render_die   => 1,
});

=head1 NAME

CookBloks::View::TTsite - Catalyst TTSite View

=head1 SYNOPSIS

See L<CookBloks>

=head1 DESCRIPTION

Catalyst TTSite View.

=head1 AUTHOR

Paul Newell,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

