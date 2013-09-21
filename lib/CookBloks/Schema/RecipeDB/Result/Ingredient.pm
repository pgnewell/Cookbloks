use utf8;
package CookBloks::Schema::RecipeDB::Result::Ingredient;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CookBloks::Schema::RecipeDB::Result::Ingredient

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

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");

=head1 TABLE: C<ingredients>

=cut

__PACKAGE__->table("ingredients");

=head1 ACCESSORS

=head2 name

  data_type: 'char'
  is_nullable: 0
  size: 255

=head2 preferred_measure

  data_type: 'char'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "name",
  { data_type => "char", is_nullable => 0, size => 255 },
  "preferred_measure",
  { data_type => "char", is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->set_primary_key("name");


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-08-22 11:52:13
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:pD6CYEGYyri8w43CJhIIcQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
