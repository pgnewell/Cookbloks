use strict;
use warnings;

use CookBloks;

my $app = CookBloks->apply_default_middlewares(CookBloks->psgi_app);
$app;

