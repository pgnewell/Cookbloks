package CookBloks::Controller::Ingredients;
use strict;
use warnings;
use base qw(Catalyst::Controller::REST);

__PACKAGE__->config(
	default => 'application/json',
);

=head1 NAME

CookBloks::Controller::Ingredients - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched CookBloks::Controller::Ingredients in Ingredients.');
}


sub ingredient_list :Local :ActionClass('REST') Args(3) {
	my ($self, $c, $bit, $page, $size) = @_;
	@{$c->stash}{qw/bit page page_size/} = ($bit, $page, $size);
}

sub ingredient_search :Local :ActionClass('REST') Args(0) {
}

sub ingredient_list_GET {

    my ($self, $c) = @_;
    my ($bit, $page, $page_size) = @{$c->stash}{qw/bit page page_size/};
    my $rs = $c->model('RecipeDB')->resultset('Ingredient')->search(
        { name => {'like', "%$bit%" }},
        {
          page => $page,  # page to return (defaults to 1)
          rows => $page_size, # number of results per page
        },
    );

    my @list = map {
        {
            name => $_->name,
        }
    } $rs->all();
    $self->status_ok($c, entity => { rows => \@list });
}

sub ingredient_search_GET {

    my ($self, $c) = @_;
	my $term = $c->req->param('term');
    my $rs = $c->model('RecipeDB')->resultset('Ingredient')->search(
        { name => {'like', "%$term%" }},
    );

	my $idx = 0;
    my @list = map {
        {
			id => $idx++,
			value => $_->name,
			label => $_->name,
			measurement => $_->preferred_measure,
        }
    } $rs->all();
    $self->status_ok($c, entity => [@list] );
}

=head1 AUTHOR

Paul Newell,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
