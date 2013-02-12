package CookBloks::Controller::Step;
use Moose;
use namespace::autoclean;

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
    $c->stash(steps => [$c->model('DB::StepTypes')->find({ name => $step_name})]);

    # Set the TT template to use.  You will almost always want to do this
    # in your action methods (action methods respond to user input in
    # your controllers).
    $c->stash(template => 'recipes/test_step.tt2');
}



=head1 AUTHOR

Paul Newell,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
