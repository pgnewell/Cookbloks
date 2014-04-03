use utf8;
package CookBloks::Schema::RecipeDB::Result::DependentStep;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CookBloks::Schema::RecipeDB::Result::DependentStep

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

=head1 TABLE: C<dependent_steps>

=cut

__PACKAGE__->table("dependent_steps");

=head1 ACCESSORS

=head2 recipe

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 step

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 depended_upon

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "recipe",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "step",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "depended_upon",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</recipe>

=item * L</step>

=back

=cut

__PACKAGE__->set_primary_key("recipe", "step");

=head1 RELATIONS

=head2 step

Type: belongs_to

Related object: L<CookBloks::Schema::RecipeDB::Result::Step>

=cut

__PACKAGE__->belongs_to(
  "step",
  "CookBloks::Schema::RecipeDB::Result::Step",
  { recipe => "recipe", step => "step" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 step_recipe_depended_upon

Type: belongs_to

Related object: L<CookBloks::Schema::RecipeDB::Result::Step>

=cut

__PACKAGE__->belongs_to(
  "step_recipe_depended_upon",
  "CookBloks::Schema::RecipeDB::Result::Step",
  { recipe => "recipe", step => "depended_upon" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-12-05 16:44:03
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:mFPaW/MLtjnphcwKD++CUg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
