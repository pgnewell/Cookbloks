use utf8;
package CookBloks::Schema::Result::DependentStep;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CookBloks::Schema::Result::DependentStep

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
  is_nullable: 0

=head2 dependant

  data_type: 'integer'
  is_nullable: 0

=head2 dependent

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "recipe",
  { data_type => "integer", is_nullable => 0 },
  "dependant",
  { data_type => "integer", is_nullable => 0 },
  "dependent",
  { data_type => "integer", is_nullable => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2013-02-12 23:09:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:nghrBF/FSq7BiFjkhlsOdQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
