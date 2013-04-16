package WebSecurity::Demos::Model::NodeJS;
use Moose;
use namespace::autoclean;
use Proc::Daemon;

extends 'Catalyst::Model';

has 'node_proc', is => 'ro', isa => 'Proc::Daemon', builder => '_build_proc';

sub _build_proc {
  my ( $self ) = @_;

  my $proc = Proc::Daemon->new(
    exec_command => 'node chat_server.js',
    work_dir => '/Users/ynonperek/Courses/secure-code/WebSecurity-Demos/nodejs/',
  );

  my $ret = $proc->Init;
  return $proc;
}

__PACKAGE__->meta->make_immutable;

1;

