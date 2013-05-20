package WebSecurity::Demos::Controller::XSS::SessionHijack;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

sub LoginRequired :Chained('/')  PathPrefix CaptureArgs(0) {
  my ( $self, $c ) = @_;

  $c->stash->{user} = $c->session->{user} or $self->login_fail($c);
}

sub index :Path {
  my ( $self, $c ) = @_;
  $c->response->redirect( $c->uri_for('login') );
}

sub login :Local {
  my ( $self, $c ) = @_;

  $c->load_status_msgs;

  $c->stash->{template} = 'xss/sessionhijack/login.tt';
}

sub home :Chained('LoginRequired') {
  my ( $self, $c ) = @_;

  my $user = $c->stash->{user};

  $c->stash->{username} = $user;
  $c->stash->{users} = [ $c->model('XSS::SessionHijack')->get_all_users_for($user) ];
  $c->stash->{inbox} = $c->model('XSS::SessionHijack')->inbox_for( $user );
  $c->stash->{template} = 'xss/sessionhijack/inbox.tt';
}

sub do_Login :POST :Path(login) {
  my ( $self, $c ) = @_;
  my $m = $c->model('XSS::SessionHijack');

  my $user = $m->valid ( $c->request->parameters ) or $self->login_fail($c);

  $c->session->{user} = $user->{name};

  $c->response->redirect( $c->uri_for( 'home' ) );
}

sub do_Sendmsg :POST PathPart('send') Chained('LoginRequired') {
  my ( $self, $c ) = @_;
  my $m = $c->model('XSS::SessionHijack');

  my $user = $c->stash->{user};

  $m->send_msg( $user, $c->request->parameters );
  $c->response->redirect( $c->uri_for( 'home' ) );
}

sub login_fail :Private {
  my ( $self, $c ) = @_;

  $c->response->redirect( $c->uri_for( $self->action_for('login'),
    { mid => $c->set_error_msg("Invalid user or password" ) } ) );
  $c->response->body('Invalid user or password');
  $c->detach;
}


__PACKAGE__->meta->make_immutable;

1;
