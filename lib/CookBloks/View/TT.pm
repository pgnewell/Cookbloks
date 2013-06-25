package CookBloks::View::TT;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt2',
    INCLUDE_PATH => [
        CookBloks->path_to( 'root' ),
        CookBloks->path_to( 'root', 'src' ),
        CookBloks->path_to( 'root', 'lib' )
    ],
    render_die => 1,
);

=head1 NAME

CookBloks::View::TT - TT View for CookBloks

=head1 DESCRIPTION

TT View for CookBloks.

=head1 SEE ALSO

L<CookBloks>

=head1 AUTHOR

Paul Newell,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
