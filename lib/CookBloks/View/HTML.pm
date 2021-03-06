package CookBloks::View::HTML;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    #render_die => 1,
    # Change default TT extension
    TEMPLATE_EXTENSION => '.tt2',
    # Set the location for TT files
    INCLUDE_PATH => [
        CookBloks->path_to( 'root' ),
        CookBloks->path_to( 'root', 'src' ),
        CookBloks->path_to( 'root', 'lib' )
    ],
    # Set to 1 for detailed timer stats in your HTML as comments
    TIMER              => 0,
    # This is your wrapper template located in the 'root/src'
    WRAPPER => 'site/wrapper',
);

=head1 NAME

CookBloks::View::HTML - TT View for CookBloks

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
