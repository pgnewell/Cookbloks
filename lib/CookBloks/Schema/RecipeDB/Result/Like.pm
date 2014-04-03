use utf8;
package CookBloks::Schema::RecipeDB::Result::Like;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CookBloks::Schema::RecipeDB::Result::Like

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

=head1 TABLE: C<likes>

=cut

__PACKAGE__->table("likes");

=head1 ACCESSORS

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 recipe_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "recipe_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</user_id>

=item * L</recipe_id>

=back

=cut

__PACKAGE__->set_primary_key("user_id", "recipe_id");

=head1 RELATIONS

=head2 recipe

Type: belongs_to

Related object: L<CookBloks::Schema::RecipeDB::Result::Recipe>

=cut

__PACKAGE__->belongs_to(
  "recipe",
  "CookBloks::Schema::RecipeDB::Result::Recipe",
  { id => "recipe_id" },
  { is_deferrable => 0, on_delete => "CASCADE,", on_update => "CASCADE," },
);

=head2 user

Type: belongs_to

Related object: L<CookBloks::Schema::RecipeDB::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "CookBloks::Schema::RecipeDB::Result::User",
  { id => "user_id" },
  { is_deferrable => 0, on_delete => "CASCADE,", on_update => "CASCADE," },
);


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-12-05 16:44:04
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:dyn81zvv+egSD6MfIl1+/w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
