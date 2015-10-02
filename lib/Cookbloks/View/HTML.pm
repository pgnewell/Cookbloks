package Cookbloks::View::HTML;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt2',
    render_die => 1,
);

=head1 NAME

Cookbloks::View::HTML - TT View for Cookbloks

=head1 DESCRIPTION

TT View for Cookbloks.

=head1 SEE ALSO

L<Cookbloks>

=head1 AUTHOR

Paul Newell,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
