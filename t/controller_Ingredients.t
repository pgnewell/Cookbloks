use strict;
use warnings;
use Test::More;


use Catalyst::Test 'CookBloks';
use CookBloks::Controller::Ingredients;

ok( request('/ingredients')->is_success, 'Request should succeed' );
done_testing();
