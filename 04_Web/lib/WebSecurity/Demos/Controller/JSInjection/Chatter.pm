package WebSecurity::Demos::Controller::JSInjection::Chatter;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

sub index :Path {
  my ( $self, $c ) = @_;

  my $socketio_port = 3100;

  my $host = $c->uri_for()->host;
  $c->stash->{socketio_host} = "http://$host:$socketio_port";
  $c->stash->{template} = 'jsinjection/chatter/chat.tt';
}


__PACKAGE__->meta->make_immutable;

1;

