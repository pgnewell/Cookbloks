package CookBloks::Controller::REST;
use strict;
use warnings;
use base qw(Catalyst::Controller::REST);

__PACKAGE__->config(
	default => 'application/json',
);

use List::MoreUtils qw(indexes);
use GD::Image; 
use GD::Image::Thumbnail;

our @step_fields;
our @ing_fields;
our @post_step_fields;
our @post_ing_fields;

sub _set_parameters {
	my $post = shift;
	@post_step_fields or @post_step_fields = grep {/^step-/} keys %{$post};
	@step_fields or @step_fields = map {s/step-//;$_;} @post_step_fields;
	@post_ing_fields or @post_ing_fields = grep {/^ing-/} keys %{$post};
	@ing_fields or @ing_fields = map {s/ing-//;$_;} @post_ing_fields;
}

sub _do_uploads {
	my $c = shift;
	if ( my $upload = $c->request->upload('image') ) {
		my $dir = "./root/images/" . $c->user->id ;
		my $picture_url = $dir . '/' . $upload->filename;
		-d $dir || mkdir $dir ||
			die  "Failed to create directory $dir";
		$upload->copy_to($picture_url) || 
			die  "Failed to copy " . $upload->filename . " to $picture_url: $!" ;
		my $gd = GD::Image->new( $picture_url ) ||
			die  "failed in thumbnail $picture_url: $!" ;
		my $png = $gd->thumbnail({w=>50, h=>50}) ||
			die  "failed in thumbnail $picture_url: $!" ;
		my $png_data = $png->png() ||
			die  "cannot png file $picture_url: $!" ;
		my $thumbnail = $picture_url;
		$thumbnail =~ s/\.jpg$/-50x50.png/;
		open PNG, ">$thumbnail" ||
			die  "cannot write file $thumbnail: $!" ;
		print PNG $png_data;
		close PNG;
	}
}

=head1 recipe

entity for a recipe in DB

=cut
sub recipe :Local :ActionClass('REST') Args(1) {
	my ($self, $c, $id) = @_;
	my $recipe;
	if ($id == 0) {
		my $post_recipe = $c->request->params;

		_set_parameters $post_recipe;

		my (@ings,@steps);
		if (ref $post_recipe->{"step-step"}) {
			push @steps, {map {$_, shift $post_recipe->{"step-$_"}} @step_fields}
				while (@{$post_recipe->{"step-$post_step_fields[0]"}});
		} else {
			@steps = ({map {$_, $post_recipe->{"step-$_"}} @step_fields});
		}

		if (ref $post_recipe->{"ing-ingredient"}) {
			push @ings, {map {$_, shift $post_recipe->{"ing-$_"}} @ing_fields}
				while (@{$post_recipe->{"ing-$post_ing_fields[0]"}});
		} else {
			@ings = ({map {$_, $post_recipe->{"ing-$_"}} @ing_fields});
		}

		if ($recipe) {
		} else {
			_do_uploads $c;
			$recipe = $c->model("RecipeDB::Recipe")->create( {
				name => $post_recipe->{name},
				description => $post_recipe->{description}, 
				user_id => $c->user->id,
			}) or $self->status_bad_request( { message => "failed when saving recipe: $!" } );
			for my $step (@steps) {
				my $created = $recipe->add_to_steps($step);
				foreach my $i (indexes {$_->{step} == $step->{step}} (@ings)) {
					$created->add_to_step_ingredients($ings[$i]);
				}
			}
			#$DB::single = 2;
		}
	} else {
		$recipe = $c->model('RecipeDB::Recipe')->find( 
			{ id => $id },
		);
	}
	$c->stash(id => $recipe->id);
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

response to GET request

=cut
sub recipe_GET {
	my ($self, $c) = @_;
	my $recipe = $c->model('RecipeDB')->resultset('Recipe')->find({id=>$c->stash->{id}});
	my @list = map { 
		my $uri = $_->picture_url; 
		$uri =~ s/ /%20/g;
		{
			name => $_->name,
			description => $_->description,
			picture_url => $uri,
		    author => $_->user->first_name . " " . $_->user->last_name,
			steps => [ map { 
				{ 
					step => $_->step, 
					name => $_->name, 
					instructions => $_->instructions, 
					type => $_->type, 
					ingredients => [ map {
						{
							seq => $_->seq,
							ingredient => $_->ingredient,
							measurement => $_->measurement,
							amount => $_->amount,
						}
					} $_->step_ingredients ],
				}
			} $_->steps ],
		}
	} ($recipe);
	$self->status_ok($c, entity => $list[0] );
}

=head1 recipe_POST

response to POST request

=cut
sub recipe_POST {
	my ($self, $c) = @_;
	my $id = $c->stash->{id};
	$self->status_ok($c, entity => {id => $id});
}

=head1 recipe_PUT

response to PUT request

=cut
sub recipe_PUT {
	my ($self, $c) = @_;
	my $id = $c->stash->{id};
	$self->status_ok($c, entity => {id => $id});
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
		$uri =~ s/ /%20/g;
		{
			name => $_->name,
			description => $_->description,
			picture_url => "<img src='$uri' />",
		    author => $_->user->first_name . " " . $_->user->last_name,
		} 
	} $rs->all();
	$self->status_ok($c, entity => { rows => \@list });
}

1;
