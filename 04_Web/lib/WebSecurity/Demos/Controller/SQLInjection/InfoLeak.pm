package WebSecurity::Demos::Controller::SQLInjection::InfoLeak;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

sub describe {
  "Use SQL Injection to get information"
}

sub index :Path Args(0) {
  my ( $self, $c ) = @_;

  my $page = $c->request->param('page') || 0;

  my $posts = $c->model('MyDB')->dbh->selectall_arrayref(
    "SELECT title, text FROM blogs LIMIT $page,10",
    { Slice => {} }
  );

  $c->stash->{posts}    = $posts;
  $c->stash->{template} = 'sqlinjection/infoleak.tt';
}

sub fixed :Local {
  my ( $self, $c ) = @_;

  my $page = int( $c->request->param('page') ) || 0;

  my $posts = $c->model('MyDB')->dbh->selectall_arrayref(
    "SELECT title, text FROM blogs LIMIT ?,10",
    { Slice => {} },
    $page
  );

  $c->stash->{posts}    = $posts;
  $c->stash->{template} = 'sqlinjection/infoleak.tt';
}


__PACKAGE__->meta->make_immutable;

1;
