use strict;
use warnings;

use ActiveCookbook;

my $app = ActiveCookbook->apply_default_middlewares(ActiveCookbook->psgi_app);
$app;

