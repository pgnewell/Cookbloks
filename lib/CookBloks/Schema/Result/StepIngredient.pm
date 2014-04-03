use utf8;
package CookBloks::Schema::Result::StepIngredient;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CookBloks::Schema::Result::StepIngredient

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

=head1 TABLE: C<step_ingredients>

=cut

__PACKAGE__->table("step_ingredients");

=head1 ACCESSORS

=head2 ingredient

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 step

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 seq

  data_type: 'smallint'
  is_nullable: 0

=head2 amount

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=head2 measurement

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 recipe

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "ingredient",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "step",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "seq",
  { data_type => "smallint", is_nullable => 0 },
  "amount",
  { data_type => "varchar", is_nullable => 0, size => 20 },
  "measurement",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "recipe",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</recipe>

=item * L</step>

=item * L</seq>

=back

=cut

__PACKAGE__->set_primary_key("recipe", "step", "seq");

=head1 RELATIONS

=head2 step

Type: belongs_to

Related object: L<CookBloks::Schema::Result::Step>

=cut

__PACKAGE__->belongs_to(
  "step",
  "CookBloks::Schema::Result::Step",
  { recipe => "recipe", step => "step" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-12-04 16:17:14
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:2TXnxCbceNTiYaYDm9MwnQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
