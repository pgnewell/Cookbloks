package CookBloks::Controller::Step;
use Moose;
use namespace::autoclean;
use File::Slurp;
use Data::Dumper;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

CookBloks::Controller::Step - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched CookBloks::Controller::Step in Step.');
}

sub single :Local :Args(1) {
    # Retrieve the usual Perl OO '$self' for this object. $c is the Catalyst
    # 'Context' that's used to 'glue together' the various components
    # that make up the application
    my ($self, $c, $step_name) = @_;

    # Retrieve all of the recipe records as book model objects and store in the
    # stash where they can be accessed by the TT template
    $c->stash(step => $c->model('DB::StepType')->find({ name => $step_name}));
	
    # Set the TT template to use.  You will almost always want to do this
    # in your action methods (action methods respond to user input in
    # your controllers).
    $c->stash(template => 'steps/single_step_form.tt2');
	$c->stash->{current_view} = 'HTML';
}

sub getdata :Local {
  my ($self, $c) = @_;

  my $inv_rs = $c->model('DB::Inventory')->search({});
  #$inv_rs = $self->jqgrid_page($c, $inv_rs);
  my @row_data;
  while (my $inv = $inv_rs->next) {
    my $single_row = {
      cell => [
        $inv->inv_id,
        $inv->client_id,
        $inv->amount,
        $inv->tax,
        $inv->total,
        $inv->note,
      ],
    };
    push @row_data, $single_row;
  }
  $c->stash->{json_data}{rows} = \@row_data;
  $c->stash->{current_view} = 'JSON';
}


=head1 AUTHOR

Paul Newell,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
