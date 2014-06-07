use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Cookbloks';
use Cookbloks::Controller::Recipes;

ok( request('/recipes')->is_success, 'Request should succeed' );
done_testing();
