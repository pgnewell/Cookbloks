use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ActiveCookbook';
use ActiveCookbook::Controller::Recipes;

ok( request('/recipes')->is_success, 'Request should succeed' );
done_testing();
