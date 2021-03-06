use utf8;
package CookBloks::Schema::RecipeDB::Result::Step;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CookBloks::Schema::RecipeDB::Result::Step

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

=head2 dependent_step

Type: might_have

Related object: L<CookBloks::Schema::RecipeDB::Result::DependentStep>

=cut

__PACKAGE__->might_have(
  "dependent_step",
  "CookBloks::Schema::RecipeDB::Result::DependentStep",
  { "foreign.recipe" => "self.recipe", "foreign.step" => "self.step" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 dependent_steps_recipes_depended_upon

Type: has_many

Related object: L<CookBloks::Schema::RecipeDB::Result::DependentStep>

=cut

__PACKAGE__->has_many(
  "dependent_steps_recipes_depended_upon",
  "CookBloks::Schema::RecipeDB::Result::DependentStep",
  {
    "foreign.depended_upon" => "self.step",
    "foreign.recipe"        => "self.recipe",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 recipe

Type: belongs_to

Related object: L<CookBloks::Schema::RecipeDB::Result::Recipe>

=cut

__PACKAGE__->belongs_to(
  "recipe",
  "CookBloks::Schema::RecipeDB::Result::Recipe",
  { id => "recipe" },
  { is_deferrable => 0, on_delete => "CASCADE,", on_update => "CASCADE," },
);

=head2 step_ingredients

Type: has_many

Related object: L<CookBloks::Schema::RecipeDB::Result::StepIngredient>

=cut

__PACKAGE__->has_many(
  "step_ingredients",
  "CookBloks::Schema::RecipeDB::Result::StepIngredient",
  { "foreign.recipe" => "self.recipe", "foreign.step" => "self.step" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 type

Type: belongs_to

Related object: L<CookBloks::Schema::RecipeDB::Result::StepType>

=cut

__PACKAGE__->belongs_to(
  "type",
  "CookBloks::Schema::RecipeDB::Result::StepType",
  { id => "type" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE,",
    on_update     => "CASCADE,",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-12-05 16:44:05
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:pBN0XnrqjnfkNTzNwy7HEQ

__PACKAGE__->might_have(
  "dependants",
  "CookBloks::Schema::RecipeDB::Result::RecipeFlow",
  { "foreign.recipe" => "self.recipe", "foreign.d_step" => "self.step" },
  { cascade_copy => 0, cascade_delete => 0 },
);

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
