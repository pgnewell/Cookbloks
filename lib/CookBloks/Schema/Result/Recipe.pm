use utf8;
package CookBloks::Schema::Result::Recipe;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CookBloks::Schema::Result::Recipe

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

=head1 TABLE: C<recipes>

=cut

__PACKAGE__->table("recipes");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'recipes_id_seq'

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 description

  data_type: 'varchar'
  default_value: null
  is_nullable: 1
  size: 255

=head2 picture_url

  data_type: 'varchar'
  default_value: null
  is_nullable: 1
  size: 255

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 ts

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=head2 created

  data_type: 'timestamp'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "recipes_id_seq",
  },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "description",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 255,
  },
  "picture_url",
  {
    data_type => "text",
    default_value => \"null",
    is_nullable => 1,
	is_fs_column => 1,
	fs_column_path => CookBloks->path_to( 'root', 'images' ) . "",
  },
  "thumbnail",
  {
    data_type => "text",
    default_value => \"null",
    is_nullable => 1,
	is_fs_column => 1,
	fs_column_path => CookBloks->path_to( 'root', 'images' ) . "",
  },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "ts",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
  "created",
  { data_type => "timestamp", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 likes

Type: has_many

Related object: L<CookBloks::Schema::Result::Like>

=cut

__PACKAGE__->has_many(
  "likes",
  "CookBloks::Schema::Result::Like",
  { "foreign.recipe_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 steps

Type: has_many

Related object: L<CookBloks::Schema::Result::Step>

=cut

__PACKAGE__->has_many(
  "steps",
  "CookBloks::Schema::Result::Step",
  { "foreign.recipe" => "self.id" },
  { cascade_copy => 0, cascade_delete => 1, order_by => \'step ASC'},
);

=head2 user

Type: belongs_to

Related object: L<CookBloks::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "CookBloks::Schema::Result::User",
  { id => "user_id" },
  { is_deferrable => 0, on_delete => "CASCADE,", on_update => "CASCADE," },
);

=head2 users

Type: many_to_many

Composing rels: L</likes> -> user

=cut

__PACKAGE__->many_to_many("users", "likes", "user");


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-12-04 16:17:14
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:7ify/4cRdH58UK1NT+nWwQ

=head2 dependents

Type: has_many

Related object: L<CookBloks::Schema::Result::DependentStep>

=cut

__PACKAGE__->has_many(
  "dependants",
  "CookBloks::Schema::Result::RecipeFlow",
  { "foreign.d_recipe" => "self.id" },
  { cascade_copy => 0, cascade_delete => 1 },
);

=head2 recursive_save

=over 4

=item Arguments: \%values

=item Return Value: ?

=back

What update should do but it doesn't - not that this does it well

=cut

sub recursive_save {
	my $self = shift;
	my $news = shift;
	ref $news eq "ARRAY" or $news = [ $news ];
	foreach my $new (@$news) {
		#my %current = map {$_ => $self->$_} $self->columns;
		my %changes = map {
			my $cmp = defined $new->{$_} && ($self->result_source->{_columns}->{$_}->{data_type} =~ /char$/i ? 
				$self->$_ cmp $new->{$_} : $self->$_ <=> $new->{$_});
			$cmp && { $_ => delete $new->{$_} } || ()
		} $self->columns;
		foreach ($self->relationships) {
			defined $new->{$_} && $self->$_->can('recursive_save') &&
				$self->$_->recursive_save($new->{$_});
		}
	}
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
