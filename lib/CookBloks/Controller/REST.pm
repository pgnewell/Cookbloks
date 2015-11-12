package CookBloks::Controller::REST;
use strict;
use warnings;
use base qw(Catalyst::Controller::REST);

__PACKAGE__->config(
	default => 'application/json',
);

use GD::Image; 
use GD::Image::Thumbnail;
use Cwd;

our @step_fields;
our @ing_fields;
our @post_step_fields;
our @post_ing_fields;

# We use the error action to handle errors
sub error :Private {
  my ( $self, $c, $code, $reason ) = @_;
  $reason ||= 'Unknown Error';
  $code ||= 500;
 
  $c->res->status($code);
# Error text is rendered as JSON as well
  $c->stash->{data} = { error => $reason };
}

# multiple value fields in POST are prefixed with step- and ing- 
# for steps and ingredients
# remove prefix for use in the database
sub _set_parameters {
	my $post = shift;
	@post_step_fields or @post_step_fields = grep {/^step-/} keys %{$post};
	@step_fields or @step_fields = map {s/step-//;$_;} @post_step_fields;
	@post_ing_fields or @post_ing_fields = grep {/^ing-/} keys %{$post};
	@ing_fields or @ing_fields = map {s/ing-//;$_;} @post_ing_fields;
}

# deal the uploaded picture. assumes just one that's image
sub _do_image_uploads {
	my ($picture_url, $thumbnail);
	my $c = shift;
	if ( my $upload = $c->request->upload('image') ) {
		my $olddir = getcwd;
		chdir "./root";
		my $dir = "/images/" . $c->user->id ;
		$picture_url = $dir . '/' . $upload->filename;
		-d $dir || mkdir $dir || die  "Failed to create directory $dir";
		my $file = ".$picture_url";
		$upload->copy_to($file) || 
			die  "Failed to copy " . $upload->filename . " to $picture_url: $!" ;
		my $gd = GD::Image->new( $file ) ||
			die  "failed in thumbnail $picture_url: $!" ;
		my $png = $gd->thumbnail({w=>50, h=>50}) ||
			die  "failed in thumbnail $file: $!" ;
		my $png_data = $png->png() ||
			die  "cannot png file $file: $!" ;
		$thumbnail = $file;
	   	$thumbnail =~ s/\.jpg$/-50x50.png/;
		open PNG, ">$thumbnail" ||
			die  "cannot write file $thumbnail: $!" ;
		print PNG $png_data;
		close PNG;
	}
	return ( $picture_url, $thumbnail );
}

# get the recipe from the POSTed params put it in a resultset objcet
# return undef if no name
sub _deserialize_from_params {
	my $c = shift;
	my $post_recipe = $c->request->params;
	my $id = $post_recipe->{'recipe-id'};
	return unless $post_recipe->{name};

	my %recipe = map {$_ => $post_recipe->{$_}} qw/name description/;
	@recipe{ qw/picture_url thumbnail/ } = _do_image_uploads $c;

	$recipe{id} = $id;
	$recipe{user_id} = $c->user->id;

	_set_parameters $post_recipe;
	my (@ings,@steps);
	# disambiguate between array and single row step from POST variables
	if (ref $post_recipe->{"step-step"}) {
		push @steps, {map {$_, shift $post_recipe->{"step-$_"}} @step_fields}
			while (@{$post_recipe->{"step-$post_step_fields[0]"}});
	} else {
		@steps = ({map {$_, $post_recipe->{"step-$_"}} @step_fields});
	}
	$id or $_->{recipe} = $id foreach (@steps);

	# same for ingredients 
	if (ref $post_recipe->{"ing-ingredient"}) {
		push @ings, {map {$_, shift $post_recipe->{"ing-$_"}} @ing_fields}
			while (@{$post_recipe->{"ing-$post_ing_fields[0]"}});
	} else {
		@ings = ({map {$_, $post_recipe->{"ing-$_"}} @ing_fields});
	}
	$id or $_->{recipe} = $id foreach (@ings);

	# create recipe object and assemble related entities for insertion
	#my $recipe = $c->model("RecipeDB")->resultset("Recipe")->new( \%recipe );
	foreach my $step (@steps) {
		$step->{dependent_steps_recipes_depended_upon} = [];
		if (my $depend = delete $step->{depended_upon}) {
			unshift $step->{dependent_steps_recipes_depended_upon}, 
				{ step  => $depend };
		}
		$step->{step_ingredients} = [
			grep {$_->{step} 
					&& $_->{step} == $step->{step} 
					&& delete $_->{step}} 
				(@ings)
		];
	}
	$recipe{steps} = \@steps;

	return \%recipe;
}

=head1 recipe

entity for a recipe in DB

=cut
sub recipe :Local ActionClass('REST') {
	my ($self, $c, $id) = @_;
	my $saved_recipe;
	if ( defined $id && $id > 0) {
		$saved_recipe = $c->model('RecipeDB::Recipe')->find( { id => $id },);
	} else {
		$saved_recipe = $c->model('RecipeDB::Recipe')->new({});
	}
	$c->stash(id => $id, recipe => $saved_recipe);
}

=head1 recipe_list

a recipe_list

=cut

sub recipe_list :Local :ActionClass('REST') Args(2) {
	my ($self, $c, $page, $lines) = @_;
	$page ||= 1;
	$lines ||= 20;
	$c->stash(page => $page, page_size => $lines);
}

=head1 recipe_GET

response to GET request - like what I want TO_JSON to do but more agressive 
with the relationships.

=cut
sub recipe_GET {
	my ($self, $c) = @_;
	my $recipe = $c->stash->{recipe};
	my @list = map { 
		my $uri = $_->picture_url;
		$uri =~ s/ /%20/g; 
		{
			id => $_->id,
			name => $_->name,
			description => $_->description,
			picture_url => $uri,
		    author => $_->user->first_name . " " . $_->user->last_name,
			steps => [ map { { 
				step => $_->step, 
				name => $_->name, 
				instructions => $_->instructions, 
				type => $_->type, 
				ingredients => [ map { {
					seq => $_->seq,
					ingredient => $_->ingredient,
					measurement => $_->measurement,
					amount => $_->amount,
				} } $_->step_ingredients ],
				$_->dependent_steps_recipes_depended_upon ? 
				(depends_upon => [ map { 
					$_ && { step => $_->depended_upon } || ()
				} $_->dependent_steps_recipe_step ]) : (),
			} } $_->steps ],
		}
	} ($recipe);
	$self->status_ok($c, entity => $list[0] );
}

=head1 recipe_POST

handles a POST request
A post should be used to create a new entity, i.e. one that yet has no
id or URI address (which would be [domain]/rest/recipe/[id])

=cut
sub recipe_POST {
	my ($self, $c) = @_;
	$c->detach('error', [404, "Must be logged in to save a recipe"]) unless $c->user && $c->user->id;
	my $recipe = $c->stash->{recipe};
	$recipe->insert();
	$self->status_ok($c, entity => {id => $recipe->id});
}

=head1 recipe_PUT

handles a PUT request
A PUT should work with an existing URI, so an id should be available
and generally an update is done or a delete/insert with primary key 
specified

=cut
sub recipe_PUT {
	my ($self, $c) = @_;
	$c->detach('error', [404, "Must be logged in to save a recipe"]) unless $c->user && $c->user->id;
	my $id = $c->stash->{id};
	my $saved_recipe = $c->stash->{recipe};
	my $form_recipe = _deserialize_from_params( $c );
	$form_recipe->{id} || delete $form_recipe->{id};
	#$saved_recipe->set_inflated_columns($form_recipe);
	#$c->model('RecipeDB')->schema->txn_do(
	#    sub {
			$saved_recipe = DBIx::Class::ResultSet::RecursiveUpdate::Functions::recursive_update(
				resultset => $c->model('RecipeDB')->schema->resultset('Recipe'),
				updates => $form_recipe,
			);
	#       $saved_recipe->discard_changes;
	#   }
	#);
	#$saved_recipe->recursive_save( $form_recipe );

	$self->status_ok($c, entity => {id => $saved_recipe->id});
}

=head1 recipe_list_GET

entity for a recipe in DB

=cut
sub recipe_list_GET {
	my ($self, $c) = @_;
	my ($page, $page_size) = @{$c->stash}{qw/ page page_size/};
	my $rs = $c->model('RecipeDB')->resultset('Recipe')->search(
		undef,
		{
		  page => $page,  # page to return (defaults to 1)
		  rows => $page_size, # number of results per page
		},
	);

	my @list = map { 
		my $uri = $_->picture_url;
		$uri or $uri = "/images/0/brioches.png";
		$uri and $uri =~ s/ /%20/g; 
		{
			id => $_->id,
			name => $_->name,
			description => $_->description,
			picture_url => "<img src='$uri' />",
		    author => $_->user->first_name . " " . $_->user->last_name,
		} 
	} $rs->all();
	$self->status_ok($c, entity => { rows => \@list });
}

=head1 recipe_flow 

a hierarchical list of steps of recipes

=cut

sub recipe_flow :Local :ActionClass('REST') Args(1) {
	my ($self, $c, $id) = @_;
	$c->stash( id => $id );

}

sub get_dependent_steps {
	[ 
		map { 
			$_ && { # The && is required because $dependants gives an array of one undef when empty
				step => $_->step->step, 
				name => $_->step->name, 
				instructions => $_->step->instructions, 
				type => $_->step->type && $_->step->type->name || "(none)", 
				ingredients => [ map { {
					seq => $_->seq,
					ingredient => $_->ingredient,
					measurement => $_->measurement,
					amount => $_->amount,
				} } $_->step->step_ingredients ],
				dependent_steps => get_dependent_steps( $_->step->dependants ),
			} 
		} @_
	];
}

=head1 recipe_flow_GET

a hierarchical list of steps of recipes

=cut

sub recipe_flow_GET {
	my ($self, $c) = @_;

	my $id = $c->stash->{id};
	my $recipe = $c->model('RecipeDB')->resultset('Recipe')->find( {id => $id} );
	my %recipe = ( 
		id => $recipe->id,
		name => $recipe->name,
		description => $recipe->description,
		author => $recipe->user->first_name . " " . $recipe->user->last_name,
	);
	$recipe{steps} = get_dependent_steps( $recipe->dependants );

	$self->status_ok($c, entity => { recipe => \%recipe });
}
sub recipe_DELETE {
	my ($self, $c) = @_;
	my $recipe = $c->stash->{recipe};
	$recipe->delete();
	$self->status_ok($c);
}

1;
