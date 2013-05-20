package WebSecurity::Demos::Model::MyDB;

use strict;
use warnings;
use parent 'Catalyst::Model::DBI';

__PACKAGE__->config(
  dsn           => '',
  user          => '',
  password      => '',
  options       => {},
);

=head1 NAME

WebSecurity::Demos::Model::MyDB - DBI Model Class

=head1 SYNOPSIS

See L<WebSecurity::Demos>

=head1 DESCRIPTION

DBI Model Class.

=head1 AUTHOR

Ynon Perek

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
