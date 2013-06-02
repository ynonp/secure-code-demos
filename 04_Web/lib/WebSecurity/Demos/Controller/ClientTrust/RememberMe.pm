package WebSecurity::Demos::Controller::ClientTrust::RememberMe;
use Moose;
use namespace::autoclean;
use MIME::Base64;

BEGIN { extends 'WebSecurity::Demos::Controller::XSS::SessionHijack'; }

sub describe {
  "Remember me gone bad"
}

sub LoginRequired :Chained('/')  PathPrefix CaptureArgs(0) {
  my ( $self, $c ) = @_;

  my $memory = $c->request->cookie('remember');
  if ( $memory ) {
    my $val = decode_base64( $memory->value );
    $c->session->{user} = $val;
  }

  $c->stash->{user} = $c->session->{user} or $self->login_fail($c);
}

sub do_Login :POST :Path(login) {
  my ( $self, $c ) = @_;
  my $m = $c->model('XSS::SessionHijack');

  my $user = $m->valid ( $c->request->parameters ) or $self->login_fail($c);

  $c->session->{user} = $user->{name};


  if ( $user->{remember_me} ) {
    my $val = encode_base64( $user->{name} );
    $c->response->cookies->{remember} = { value => $val };
  }

  $c->response->redirect( $c->uri_for( 'home' ) );
}

__PACKAGE__->meta->make_immutable;
1;
