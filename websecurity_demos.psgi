use strict;
use warnings;

use WebSecurity::Demos;

my $app = WebSecurity::Demos->apply_default_middlewares(WebSecurity::Demos->psgi_app);
$app;

