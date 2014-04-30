package CookBloks::Controller::User;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }
use CookBloks::Form::User;

has 'form' => ( isa => 'CookBloks::Form::User', is => 'rw',
   lazy => 1, default => sub { CookBloks::Form::User->new } );

=head1 NAME

CookBloks::Controller::User - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched CookBloks::Controller::User in User.');
}

=head2 login

Login logic

=cut

sub login :Local :Args(0) {
	my ($self, $c) = @_;

	# Get the username and password from form
	my $username = $c->request->params->{username};
	my $password = $c->request->params->{password};

	# If the username and password values were found in form
	if ($username && $password) {
		# Attempt to log the user in
		unless ($c->authenticate({ username => $username,
							   password => $password  } )) {
			# Set an error message
			$c->stash(error_msg => "Bad username or password.");
		}
	} else {
		# Set an error message
		$c->stash(error_msg => "Empty username or password.")
			unless ($c->user_exists);
	}
	#$c->response->redirect($c->uri_for( '/formula/list' ));
		#$c->controller('Root')->action_for('/')));

	# If either of above don't work out, send to the login page
}

=head2 dump

Logout logic

=cut

sub dump :Local :Args(0) {
	my ($self, $c) = @_;

	$c->stash( template => 'site/user-dump.tt2' );
	return;
}

=head2 logout

Logout logic

=cut

sub logout :Local :Args(0) {
	my ($self, $c) = @_;

	# Clear the user's state
	$c->logout;

	# Send the user to the starting point
	#$c->response->redirect($c->uri_for('/'));
	$c->response->redirect($c->uri_for( '/formula/list' ));
		#$c->controller('Root')->action_for('/')));
	return;
}

sub edit : Local {
	my ( $self, $c, $user_id ) = @_;

	$c->stash( template => 'users/edit.tt2',
			   form => $self->form );

	# Validate and insert/update database
	return unless $self->form->process( item_id => $user_id,
	   params => $c->req->parameters,
	   schema => $c->model('RecipeDB')->schema );

	# Form validated, return to the users list
	$c->flash->{status_msg} = 'User saved';
	$c->res->redirect($c->uri_for('list'));
}

sub list : Local {
	my ( $self, $c, $user_id ) = @_;
	my $users = $c->model('RecipeDB::User')->search();

	$c->stash( 
		template => 'users/list.tt2', 
		users => $users,
	);
	return;
}

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
