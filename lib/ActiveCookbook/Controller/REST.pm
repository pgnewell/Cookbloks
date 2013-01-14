package ActiveCookbook::Controller::REST;
use strict;
use warnings;
use base qw { Catalyst::Controller::REST };
__PACKAGE__->config->{serialize}{default} = 'JSON';
1;
