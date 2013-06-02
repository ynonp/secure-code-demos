package WebSecurity::Demos::Controller::SQLInjection::Login;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

sub describe {
  "Use SQL Injection to break login page"
}

# GET /
sub index :GET Path Args(0) {
    my ( $self, $c ) = @_;

    $c->load_status_msgs;
    $c->stash->{template} = 'sqlinjection/login.tt';
}

# POST /
sub do_login :POST Path Args(0) {
  my ( $self, $c ) = @_;
  my $user = $c->request->param('user') or $self->fail($c);
  my $pass = $c->request->param('pass') or $self->fail($c);

  my $db_users_ref = $c->model('MyDB')->dbh->selectrow_hashref(
    "SELECT name, pass FROM users WHERE name='$user'"
  );

  if ( $db_users_ref->{pass} eq $pass ) {
    $c->response->body("Welcome, Master");
  } else {
    $self->fail($c);
  }
}


sub fail {
  my ( $self, $c ) = @_;

  $c->response->redirect( $c->uri_for( $self->action_for('index'),
      { mid => $c->set_error_msg("Invalid user or password" ) } ) );
  $c->detach;
}

sub debug :Local {
  my ( $self, $c ) = @_;

  my $users_ref = $c->model('MyDB')->dbh->selectall_arrayref(
    "SELECT name FROM users",
    { Slice => {} }
  );
  $c->response->body ( Dumper( $users_ref ) );
}

__PACKAGE__->meta->make_immutable;

1;
