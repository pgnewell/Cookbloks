package CookBloks::Controller::REST::User;
use Moose;
use namespace::autoclean;

BEGIN { extends 'CookBloks::Controller::REST'; }

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

    $c->response->body('Matched CookBloks::Controller::REST::User in User.');
}

=head2 login

Login logic

=cut

sub login :Local :ActionClass('REST') :Args(0) {
	my ($self, $c) = @_;
}

sub login_POST {
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
			$c->session(error_msg => "Bad username or password" );
			$self->status_forbidden($c, message => "Login failed");
		}
	} else {
		# Set an error message
		$c->session(error_msg => "Empty username or password" )
			unless ($c->user_exists);
		$self->status_no_content($c);
	}
	#$c->response->redirect($c->uri_for( '/formula/list' ));
		#$c->controller('Root')->action_for('/')));

	# If either of above don't work out, send to the login page
	$self->status_ok($c, entity => { user => $c->user->username });
}

=head2 logout

Logout logic

=cut

sub logout :Local :ActionClass('REST') :Args(0) {
	my ($self, $c) = @_;
}

sub logout_POST {
	my ($self, $c) = @_;
	# Clear the user's state
	$c->logout;

	# Send the user to the starting point
	#$c->response->redirect($c->uri_for('/'));
	#$c->response->redirect($c->uri_for( '/formula/list' ));
		#$c->controller('Root')->action_for('/')));
	$self->status_ok($c, entity => $c->user);
}

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;

