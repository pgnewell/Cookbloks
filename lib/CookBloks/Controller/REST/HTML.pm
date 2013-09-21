package CookBloks::Controller::REST::HTML;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller::REST'; }

__PACKAGE__->config(
      map => {
          'text/html' => [ 'View', 'Empty' ],
          'html' => [ 'View', 'Empty' ],
          '*/*' => [ 'View', 'TT' ],
      }
  );

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->response->body('Matched CookBloks::Controller::REST::HTML in HTML.');
}

=head1 menu


=cut
sub menu :Local :ActionClass('REST') Args(1) {
	my ($self, $c, $template) = @_;
	$c->stash(template => "site/$template");
}

sub menu_GET {
	my ($self, $c) = @_;
	my $rendering = $c->view("Empty")->render($c, $c->stash->{template});
	$self->status_ok($c, entity => $rendering);
}

1;
