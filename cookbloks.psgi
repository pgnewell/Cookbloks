use strict;
use warnings;

use Cookbloks;

my $app = Cookbloks->apply_default_middlewares(Cookbloks->psgi_app);
$app;

