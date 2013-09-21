package CookBloks::Controller::Recipe;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

#with 'Catalyst::TraitFor::Controller::jQuery::jqGrid';

=head1 NAME

CookBloks::Controller::Recipe - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
	my ( $self, $c ) = @_;

	$c->response->body('Matched CookBloks::Controller::Recipe in Recipe.');
}

sub json_list :Local :Args(0) {
	my ($self, $c, $name) = @_;

	my $formulas = $c->model('RecipeDB::Recipe')->search({});
	#$formulas = $self->jqgrid_page($c, $formulas);
	my @row_data;
	while (my $formula = $formulas->next) {
		my $single_row = {
		    name => $formula->name,
		    desc => $formula->description,
		    picture => $formula->picture_url,
		    author => $formula->user->first_name . " " . $formula->user->last_name,
		};
		push @row_data, $single_row;
	}
	$c->stash->{json_data}{rows} = \@row_data;
	$c->stash->{current_view} = 'JSON';
}

sub insert :Local :Args(0) {
	my ($self, $c) = @_;

	# Retrieve the values from the form
	my $name     = $c->request->params->{name}     || 'N/A';
	my $desc     = $c->request->params->{desc}     || 'N/A';
	my $picture  = $c->request->params->{picture}     || 'N/A';
	my $author   = $c->request->params->{author}     || 'N/A';

	# 
	my $formula = $c->model('RecipeDB::Recipe')->create({
		name  => $name,
		description  => $desc,
		picture_url  => $picture,
		user_id  => $author,
	});
	# Handle relationship with author
	#-- $book->add_to_book_authors({author_id => $author_id});
	# Note: Above is a shortcut for this:
	# $book->create_related('book_authors', {author_id => $author_id});

	# Store new model object in stash and set template
	$c->stash(formula => $formula,);
}

# this class is a HTML::FormHandler class that we'll define below
use CookBloks::Form::Recipe;
 
sub formulas : Chained('/') PathPart('formula') CaptureArgs(0) {
	my ($self, $c) = @_;
	$c->stash->{formulas} = $c->model('RecipeDB::Recipe');
}
 
sub list : Chained('formulas') Local Args(0) {
	my ($self, $c) = @_;
	$c->stash->{recipes} = $c->stash->{formulas}->search({});
	$c->stash->{current_view} = 'HTML';
	$c->stash->{template} = 'index.tt2';      
}
 
sub formula : Chained('formulas') PathPart('') CaptureArgs(1) {
	my ($self, $c, $id) = @_;

	$c->error("ID isn't valid!") unless $id =~ /^\d+$/;
	$c->stash->{formula} = $c->stash->{formulas}->find($id)
		|| $c->detach('not_found');
}
 

sub dump :Chained('formula') :PathPart('dump') :Args(0) {
    my ($self, $c) = @_;
	
	$c->stash(	object => $c->stash->{formula},
				template => 'utils/dump.tt2');
}

sub edit : Chained('formula') {
	my ($self, $c) = @_;
	$c->stash(template => 'recipe-form.tt2');
}
 
sub add : Chained('formulas') {
	my ($self, $c) = @_;
	$c->stash(template => 'recipe-form.tt2');
}
 
# both adding and editing happens here
# no need to duplicate functionality
sub save :Chained('formulas') :PathPart('save') :Args(0) {
	my ($self, $c) = @_;
	my $userid = 0; # ---
	my %sv;
	@sv{ qw/name description picture_url/ } = @{$c->request->params}{ qw/ name description image/ };
	if ( my $upload = $c->request->upload('image') ) {
		my $filename = $upload->filename;
		my $target   = "./root/images/$userid/$filename";
		$sv{picture_url} = $target;
		unless ( $upload->copy_to($target) ) {
			die( "Failed to copy '$filename' to '$target': $!" );
		}
	}
	$sv{user_id} = $c->user->{id};

	my $recipe = $c->model('RecipeDB::Recipe')->create( \%sv );
}

sub save_form : Private {
	my ($self, $c) = @_;

	# if the item doesn't exist, we'll just create a new result
	my $item = $c->stash->{formula} || $c->model('RecipeDB::Recipe')->new_result({});
	my $form = CookBloks::Form::Recipe->new( formula => $item );

	$c->stash( form => $form, template => 'formula/save.tt2' );

	# the "process" call has all the saving logic,
	#   if it returns False, then a validation error happened
	$c->stash->{current_view} = 'TT';
	return unless $form->process( params => $c->req->params  );

	# $c->flash->{info_msg} = "Article saved!";
	$c->redirect_to_action('Recipe', 'edit', [$item->article_id]);
}
 
sub thumbnail :Local :Args(2) {
	my ($self, $c, $user_id, $image_file_path) = @_;

	$c->stash->{x}     = 100;    # Create a 100px wide thumbnail
	$c->stash->{y}     = 100;    # Create a 100px tall thumbnail
	$c->stash->{image} = "/images/$user_id/$image_file_path";

	$c->forward('View::Thumbnail');
}

sub not_found : Local {
	my ($self, $c) = @_;
	$c->response->status(404);
	$c->stash->{error_msg} = "Recipe not found!";
	$c->detach('list');
}

=head1 AUTHOR

Paul Newell,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
