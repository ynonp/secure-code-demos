package WebSecurity::Demos::Model::Companies;
use Moose;
use namespace::autoclean;

use XML::XPath;
use LWP::Simple;

extends 'Catalyst::Model';

has 'db', is => 'ro', isa => 'XML::XPath', builder => '_build_db';

sub _build_db {
  my $xmldata = get 'http://www.isa.gov.il/data/companies-en.xml';
  return XML::XPath->new( xml => $xmldata );
}

__PACKAGE__->meta->make_immutable;

1;
