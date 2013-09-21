use strict;
use warnings;
use Test::More;


use Catalyst::Test 'CookBloks';
use CookBloks::Controller::Recipe;

ok( request('/recipe')->is_success, 'Request should succeed' );
done_testing();
