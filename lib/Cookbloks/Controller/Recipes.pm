package Cookbloks::Controller::Recipes;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Cookbloks::Controller::Recipes - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Cookbloks::Controller::Recipes in Recipes.');
}


=head2 list
    
    Fetch all book objects and pass to books/list.tt2 in stash to be displayed
    
=cut
    
sub list :Local {
	# Retrieve the usual Perl OO '$self' for this object. $c is the Catalyst
	# 'Context' that's used to 'glue together' the various components
	# that make up the application
	my ($self, $c) = @_;

	# Retrieve all of the book records as book model objects and store in the
	# stash where they can be accessed by the TT template
	$c->stash(recipes => [$c->model('DB::Recipe')->all]);
	# But, for now, use this code until we create the model later
	# $c->stash(recipes  => '');

	# Set the TT template to use.  You will almost always want to do this
	# in your action methods (action methods respond to user input in
	# your controllers).
	$c->stash(template => 'recipes/list.tt2');
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
