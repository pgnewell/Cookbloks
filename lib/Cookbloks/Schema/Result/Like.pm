use utf8;
package Cookbloks::Schema::Result::Like;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Cookbloks::Schema::Result::Like

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

Related object: L<Cookbloks::Schema::Result::Recipe>

=cut

__PACKAGE__->belongs_to(
  "recipe",
  "Cookbloks::Schema::Result::Recipe",
  { id => "recipe_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 user

Type: belongs_to

Related object: L<Cookbloks::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "Cookbloks::Schema::Result::User",
  { id => "user_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07040 @ 2014-06-07 13:55:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:m3b0aCNyx/qA99sHHP57Ew


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
