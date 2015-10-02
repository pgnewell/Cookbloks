use utf8;
package Cookbloks::Schema::Result::DependentStep;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Cookbloks::Schema::Result::DependentStep

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

=head2 step_recipe_depended_upon

Type: belongs_to

Related object: L<Cookbloks::Schema::Result::Step>

=cut

__PACKAGE__->belongs_to(
  "step_recipe_depended_upon",
  "Cookbloks::Schema::Result::Step",
  { recipe => "recipe", step => "depended_upon" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 step_recipe_step

Type: belongs_to

Related object: L<Cookbloks::Schema::Result::Step>

=cut

__PACKAGE__->belongs_to(
  "step_recipe_step",
  "Cookbloks::Schema::Result::Step",
  { recipe => "recipe", step => "step" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07040 @ 2014-06-07 13:55:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ytJ3C8IebPToDx53yE9vsA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
