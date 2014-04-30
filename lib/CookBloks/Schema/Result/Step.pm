use utf8;
package CookBloks::Schema::Result::Step;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CookBloks::Schema::Result::Step

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=item * L<DBIx::Class::PassphraseColumn>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "PassphraseColumn");

=head1 TABLE: C<steps>

=cut

__PACKAGE__->table("steps");

=head1 ACCESSORS

=head2 recipe

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 step

  data_type: 'integer'
  is_nullable: 0

=head2 type

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 instructions

  data_type: 'text'
  default_value: null
  is_nullable: 1

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "recipe",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "step",
  { data_type => "integer", is_nullable => 0 },
  "type",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "instructions",
  { data_type => "text", default_value => \"null", is_nullable => 1 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</recipe>

=item * L</step>

=back

=cut

__PACKAGE__->set_primary_key("recipe", "step");

=head1 RELATIONS

=head2 dependent_steps_recipe_step

Type: might_have

Related object: L<CookBloks::Schema::Result::DependentStep>

=cut

__PACKAGE__->might_have(
  "dependent_steps_recipe_step",
  "CookBloks::Schema::Result::DependentStep",
  { "foreign.recipe" => "self.recipe", "foreign.step" => "self.step" },
  { cascade_copy => 0, cascade_delete => 1 },
);

=head2 dependent_steps_recipes_depended_upon

Type: has_many

Related object: L<CookBloks::Schema::Result::DependentStep>

=cut

__PACKAGE__->has_many(
  "dependent_steps_recipes_depended_upon",
  "CookBloks::Schema::Result::DependentStep",
  {
    "foreign.depended_upon" => "self.step",
    "foreign.recipe"        => "self.recipe",
  },
  { cascade_copy => 0, cascade_delete => 1 },
);

=head2 recipe

Type: belongs_to

Related object: L<CookBloks::Schema::Result::Recipe>

=cut

__PACKAGE__->belongs_to(
  "recipe",
  "CookBloks::Schema::Result::Recipe",
  { id => "recipe" },
  { is_deferrable => 0, on_delete => "CASCADE,", on_update => "CASCADE," },
);

=head2 step_ingredients

Type: has_many

Related object: L<CookBloks::Schema::Result::StepIngredient>

=cut

__PACKAGE__->has_many(
  "step_ingredients",
  "CookBloks::Schema::Result::StepIngredient",
  { "foreign.recipe" => "self.recipe", "foreign.step" => "self.step" },
  { cascade_copy => 0, cascade_delete => 1 },
);

=head2 type

Type: belongs_to

Related object: L<CookBloks::Schema::Result::StepType>

=cut

__PACKAGE__->belongs_to(
  "type",
  "CookBloks::Schema::Result::StepType",
  { id => "type" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE,",
    on_update     => "CASCADE,",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-12-05 16:41:02
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ncRkLA7OPg1UzqdUQxI0dg

__PACKAGE__->might_have(
  "dependants",
  "CookBloks::Schema::Result::RecipeFlow",
  { "foreign.recipe" => "self.recipe", "foreign.d_step" => "self.step" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 recursive_save

=over 4

=item Arguments: \%values

=item Return Value: ?

=back

What update should do but it doesn't - not that this does it well

=cut

sub recursive_save {
	my $self = shift;
	my $news = shift;
	ref $news eq "ARRAY" or $news = [ $news ];
	foreach my $new (@$news) {
		#my %current = map {$_ => $self->$_} $self->columns;
		my %changes = map {
			my $cmp = defined $new->{$_} && ($self->result_source->{_columns}->{$_}->{data_type} =~ /char$/i ? 
				$self->$_ cmp $new->{$_} : $self->$_ <=> $new->{$_});
			$cmp && { $_ => delete $new->{$_} } || ()
		} $self->columns;
		foreach ($self->relationships) {
			defined $new->{$_} && $self->$_->can('recursive_save') &&
				$self->$_->recursive_save($new->{$_});
		}
	}
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
