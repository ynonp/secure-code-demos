package WebSecurity::Demos::Controller::AntiCSRF::SafeForm;

use base 'Catalyst::Controller';
use Bytes::Random::Secure qw/random_bytes_hex/;

sub describe {
  "CSRF Protection"
}

sub index :Path :Args(0) :GET {
  my ( $self, $c ) = @_;

  $c->log->info("--- REQ ---");

  $c->stash->{template} = 'anticsrf/safeform/index.tt';
}

sub do_form :Path :POST {
  my ( $self, $c ) = @_;

  $c->response->body('SUBMIT');
}

1;
