use strict;
use warnings;
use Test::More;


use Catalyst::Test 'CookBloks';
use CookBloks::Controller::Step::Single;

ok( request('/step/single')->is_success, 'Request should succeed' );
done_testing();
