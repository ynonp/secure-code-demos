use strict;
use warnings;
use Test::More;


use Catalyst::Test 'WebSecurity::Demos';
use WebSecurity::Demos::Controller::SQLInjection::Login;

ok( request('/sqlinjection/login')->is_success, 'Request should succeed' );
done_testing();
