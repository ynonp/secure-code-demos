package WebSecurity::Demos::Controller::AntiCSRF::SafeForm;

use base 'Catalyst::Controller::HTML::FormFu';

sub describe {
  "CSRF Protection"
}

sub index :Local :FormConfig {
  my ( $self, $c ) = @_;

  my $form = $c->stash->{form};

  $c->log->info("--- REQ ---");

  if ( $form->submitted_and_valid ) {
    $c->log->info("Submitted");
    $c->response->body("1");
  } else {
    $c->log->info( $form );
  }
}

1;
