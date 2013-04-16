package WebSecurity::Demos::Model::XSS::SessionHijack;
use Moose;
use namespace::autoclean;

extends 'Catalyst::Model';

my %inbox = (
  bob => [
    { from => 'jim', title => 'Hi Bob' },
  ],

  jim => [
    { from => 'bob', title => 'Hi Jim' },
  ]
);

my %users = (
  bob => 'bob',
  jim => 'jim',
);

sub get_all_users_for {
  my ( $self, $for ) = @_;

  return grep { $_ ne $for } keys %users;
}

sub inbox_for {
  my ( $self, $user ) = @_;

  die "Invalid User: $user" if ( ! $users{$user} );

  return $inbox{$user};
}

sub valid {
  my ( $self, $params ) = @_;
  my $user = $params->{login} or die "Missing login";
  my $pass = $params->{password} or die "Missing pass";

  if ( ! $users{$user} ) {
    return;
  }

  return if ! $users{$user} eq $pass;

  return $user;
}

sub send_msg {
  my ( $self, $from, $params ) = @_;

  die "Missing from" if ! $from;

  my $to = $params->{subject} or die "Missing to";
  my $msg = $params->{message} or die "Missing msg";

  $inbox{$to} ||= [];
  push $inbox{$to}, { from => $from, title => $msg };
}

__PACKAGE__->meta->make_immutable;

1;

