use utf8;
package CookBloks::Schema::RecipeDB::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CookBloks::Schema::RecipeDB::Result::User

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

=head1 TABLE: C<users>

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'users_id_seq'

=head2 created

  data_type: 'integer'
  is_nullable: 0

=head2 modified

  data_type: 'integer'
  is_nullable: 0

=head2 token

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 password

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 email

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 first_name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 last_name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 username

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "users_id_seq",
  },
  "created",
  { data_type => "integer", is_nullable => 0 },
  "modified",
  { data_type => "integer", is_nullable => 0 },
  "token",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "password",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "email",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "first_name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "last_name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "username",
  { data_type => "varchar", is_nullable => 0, size => 255 },
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

Related object: L<CookBloks::Schema::RecipeDB::Result::Like>

=cut

__PACKAGE__->has_many(
  "likes",
  "CookBloks::Schema::RecipeDB::Result::Like",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 recipes_2s

Type: has_many

Related object: L<CookBloks::Schema::RecipeDB::Result::Recipe>

=cut

__PACKAGE__->has_many(
  "recipes_2s",
  "CookBloks::Schema::RecipeDB::Result::Recipe",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 user_roles

Type: has_many

Related object: L<CookBloks::Schema::RecipeDB::Result::UserRole>

=cut

__PACKAGE__->has_many(
  "user_roles",
  "CookBloks::Schema::RecipeDB::Result::UserRole",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 recipes

Type: many_to_many

Composing rels: L</likes> -> recipe

=cut

__PACKAGE__->many_to_many("recipes", "likes", "recipe");

=head2 roles

Type: many_to_many

Composing rels: L</user_roles> -> role

=cut

__PACKAGE__->many_to_many("roles", "user_roles", "role");


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-05-30 13:09:45
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:XUOu86JuAxwZ2P3hFCrEkg

# Have the 'password' column use a SHA-1 hash and 20-byte salt
# with RFC 2307 encoding; Generate the 'check_password" method
__PACKAGE__->add_columns(
	'password' => {
		passphrase       => 'rfc2307',
		passphrase_class => 'SaltedDigest',
		passphrase_args  => {
			algorithm   => 'SHA-1',
			salt_random => 20.
		},
		passphrase_check_method => 'check_password',
	},
);

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
