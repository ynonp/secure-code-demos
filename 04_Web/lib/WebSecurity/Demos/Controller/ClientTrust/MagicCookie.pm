package WebSecurity::Demos::Controller::ClientTrust::MagicCookie;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

sub describe {
  "Some cookies are broken"
}

sub index :Path {
  my ( $self, $c ) = @_;

  $c->response->redirect( $c->uri_for('index.html'))
}

sub admin :Local {
  my ( $self, $c ) = @_;

  my $role_cookie = $c->request->cookie('role');
  if ( ! $role_cookie ) {
    return $c->response->redirect( $c->uri_for )
  }

  my $role = $role_cookie->value;

  if ( $role == 1 ) {
    $c->response->body('Welcome, Master');
  } else {
    $c->response->redirect( $c->uri_for )
  }
}

__PACKAGE__->meta->make_immutable;

1;


