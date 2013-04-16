package WebSecurity::Demos::Controller::XPathInjection::Leak;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;

  my $count = $c->request->param('count') || 10;

  my $nodes_ref = $c->model('Companies')
                    ->db
                    ->findnodes("//companies/company[position()< $count]/name");

  $c->stash->{companies} = [ $nodes_ref->get_nodelist ];
  $c->stash->{template}  = 'xpath/companies.tt';
}


__PACKAGE__->meta->make_immutable;

1;
