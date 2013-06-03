package WebSecurity::Demos::Model::NodeJS;
use Moose;
use namespace::autoclean;
use Proc::Daemon;

extends 'Catalyst::Model';

has 'worker', is => 'rw', isa => 'Proc::Daemon';
has 'work_dir', is => 'ro', isa => 'Str', required => 1;

sub COMPONENT {
  my ( $class, $app, $args ) = @_;

  return $class->new(
      work_dir => $app->path_to('nodejs')->stringify,
    );
}

sub BUILD {
  my ( $self ) = @_;

  my $proc = Proc::Daemon->new(
    exec_command => 'node chat_server.js',
    work_dir => $self->work_dir,
  );

  my $ret = $proc->Init;
  $self->worker( $proc );
  return $proc;
}

sub DEMOLISH {
  my ( $self ) = @_;
  $self->worker->Kill_Daemon;
}

__PACKAGE__->meta->make_immutable;

1;

