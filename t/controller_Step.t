use strict;
use warnings;
use Test::More;


use Catalyst::Test 'CookBloks';
use CookBloks::Controller::Step;

ok( request('/step')->is_success, 'Request should succeed' );
done_testing();
