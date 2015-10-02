use utf8;
package Cookbloks::Schema::Result::RecipeFlow;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Cookbloks::Schema::Result::RecipeFlow

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
__PACKAGE__->table_class("DBIx::Class::ResultSource::View");

=head1 TABLE: C<recipe_flow>

=cut

__PACKAGE__->table("recipe_flow");

=head1 ACCESSORS

=head2 recipe

  data_type: 'integer'
  is_nullable: 1

=head2 original_step

  data_type: 'integer'
  is_nullable: 1

=head2 step

  data_type: 'integer'
  is_nullable: 1

=head2 d_recipe

  data_type: 'integer'
  is_nullable: 1

=head2 d_step

  data_type: 'integer'
  is_nullable: 1

=head2 path

  data_type: 'integer[]'
  is_nullable: 1

=head2 type

  data_type: 'integer'
  is_nullable: 1

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 instructions

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "recipe",
  { data_type => "integer", is_nullable => 1 },
  "original_step",
  { data_type => "integer", is_nullable => 1 },
  "step",
  { data_type => "integer", is_nullable => 1 },
  "d_recipe",
  { data_type => "integer", is_nullable => 1 },
  "d_step",
  { data_type => "integer", is_nullable => 1 },
  "path",
  { data_type => "integer[]", is_nullable => 1 },
  "type",
  { data_type => "integer", is_nullable => 1 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "instructions",
  { data_type => "text", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07040 @ 2014-06-07 13:55:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:vs9x3+1IpJCa/6LeKp7bZg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
