package ActiveCookbook::View::HTML;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt2',
    render_die => 1,
);

=head1 NAME

ActiveCookbook::View::HTML - TT View for ActiveCookbook

=head1 DESCRIPTION

TT View for ActiveCookbook.

=head1 SEE ALSO

L<ActiveCookbook>

=head1 AUTHOR

Paul Newell,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
