use utf8;
package CookBloks::Schema::Result::StepType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CookBloks::Schema::Result::StepType

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

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "PassphraseColumn","Helper::Row::ToJSON");

=head1 TABLE: C<step_types>

=cut

__PACKAGE__->table("step_types");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'step_types_id_seq'

=head2 name

  data_type: 'varchar'
  default_value: null
  is_nullable: 1
  size: 255

=head2 icon_url

  data_type: 'varchar'
  default_value: null
  is_nullable: 1
  size: 255

=head2 description

  data_type: 'varchar'
  default_value: null
  is_nullable: 1
  size: 255

=head2 html

  data_type: 'varchar'
  default_value: null
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "step_types_id_seq",
  },
  "name",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 255,
  },
  "icon_url",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 255,
  },
  "description",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 255,
  },
  "html",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 255,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 steps

Type: has_many

Related object: L<CookBloks::Schema::Result::Step>

=cut

__PACKAGE__->has_many(
  "steps",
  "CookBloks::Schema::Result::Step",
  { "foreign.type" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-12-04 16:17:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:/RgZ+MF3SVa/IdDiTIGgdw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
