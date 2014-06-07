package Cookbloks::Controller::Users;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Cookbloks::Controller::Users - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Cookbloks::Controller::Users in Users.');
}


sub list :Local {
	# Retrieve the usual Perl OO '$self' for this object. $c is the Catalyst
	# 'Context' that's used to 'glue together' the various components
	# that make up the application
	my ($self, $c) = @_;

	# Retrieve all of the book records as book model objects and store in the
	# stash where they can be accessed by the TT template
	# $c->stash(books => [$c->model('DB::Book')->all]);
	# But, for now, use this code until we create the model later
	$c->stash(users => '');

	# Set the TT template to use.  You will almost always want to do this
	# in your action methods (action methods respond to user input in
	# your controllers).
	$c->stash(template => 'users/list.tt2');
}

=encoding utf8

=head1 AUTHOR

Paul Newell,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
