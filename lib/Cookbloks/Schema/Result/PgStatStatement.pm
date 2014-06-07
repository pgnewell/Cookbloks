use utf8;
package Cookbloks::Schema::Result::PgStatStatement;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Cookbloks::Schema::Result::PgStatStatement

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

=head1 TABLE: C<pg_stat_statements>

=cut

__PACKAGE__->table("pg_stat_statements");

=head1 ACCESSORS

=head2 userid

  data_type: 'oid'
  is_nullable: 1
  size: 4

=head2 dbid

  data_type: 'oid'
  is_nullable: 1
  size: 4

=head2 query

  data_type: 'text'
  is_nullable: 1

=head2 calls

  data_type: 'bigint'
  is_nullable: 1

=head2 total_time

  data_type: 'double precision'
  is_nullable: 1

=head2 rows

  data_type: 'bigint'
  is_nullable: 1

=head2 shared_blks_hit

  data_type: 'bigint'
  is_nullable: 1

=head2 shared_blks_read

  data_type: 'bigint'
  is_nullable: 1

=head2 shared_blks_written

  data_type: 'bigint'
  is_nullable: 1

=head2 local_blks_hit

  data_type: 'bigint'
  is_nullable: 1

=head2 local_blks_read

  data_type: 'bigint'
  is_nullable: 1

=head2 local_blks_written

  data_type: 'bigint'
  is_nullable: 1

=head2 temp_blks_read

  data_type: 'bigint'
  is_nullable: 1

=head2 temp_blks_written

  data_type: 'bigint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "userid",
  { data_type => "oid", is_nullable => 1, size => 4 },
  "dbid",
  { data_type => "oid", is_nullable => 1, size => 4 },
  "query",
  { data_type => "text", is_nullable => 1 },
  "calls",
  { data_type => "bigint", is_nullable => 1 },
  "total_time",
  { data_type => "double precision", is_nullable => 1 },
  "rows",
  { data_type => "bigint", is_nullable => 1 },
  "shared_blks_hit",
  { data_type => "bigint", is_nullable => 1 },
  "shared_blks_read",
  { data_type => "bigint", is_nullable => 1 },
  "shared_blks_written",
  { data_type => "bigint", is_nullable => 1 },
  "local_blks_hit",
  { data_type => "bigint", is_nullable => 1 },
  "local_blks_read",
  { data_type => "bigint", is_nullable => 1 },
  "local_blks_written",
  { data_type => "bigint", is_nullable => 1 },
  "temp_blks_read",
  { data_type => "bigint", is_nullable => 1 },
  "temp_blks_written",
  { data_type => "bigint", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07040 @ 2014-06-07 13:55:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:EQsDTvzSTcRuLWeIyTZYvA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
