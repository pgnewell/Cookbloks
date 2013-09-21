package CookBloks::View::Empty;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt2',
    render_die => 1,
    INCLUDE_PATH => [
        CookBloks->path_to( 'root' ),
        CookBloks->path_to( 'root', 'src' ),
        CookBloks->path_to( 'root', 'lib' )
    ],
);

=head1 NAME

CookBloks::View::Empty - TT View for CookBloks

=head1 DESCRIPTION

TT View for CookBloks.

=head1 SEE ALSO

L<CookBloks>

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
