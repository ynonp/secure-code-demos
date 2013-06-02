package WebSecurity::Demos::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    my @example_controllers = qw(
      SQLInjection::Login
      SQLInjection::InfoLeak
      XPathInjection::Leak
      JSInjection::Chatter
      XSS::SessionHijack
      AntiCSRF::SafeForm
      ClientTrust::MagicCookie
      ClientTrust::RememberMe
    );

    $c->stash->{toc} = [ map {
      {
        uri => $c->uri_for( $c->controller( $_)->action_for('index') ),
        name => $_,
        description => $c->controller($_)->describe,
        source => "https://github.com/ynonp/secure-code-demos/tree/master/04_Web/lib/WebSecurity/Demos/Controller/" . $_ =~ s/::/\//gr . ".pm",
      }
    } @example_controllers ];

    $c->stash->{template} = 'index.tt';
}

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

sub end : ActionClass('RenderView') {}


__PACKAGE__->meta->make_immutable;

1;
