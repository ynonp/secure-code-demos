var $container = $('#container');

var Chatter = function(nick) {
  var self = this;

  self.nick = nick;

  self.socket = io.connect('http://localhost:3100');

  self.start_chat = function( $el ) {
    self.socket.on('userlist', function(userlist) {
      userlist = userlist.filter(function(el) { return el !== self.nick } );
      var template = Handlebars.compile( $('#v-userlist').html() );
      $('#chatters-list', $el).html( template( { chatters: userlist  } ) );
    });

    self.socket.on('leave', function() {
      self.socket.emit('userlist');
    });

    self.socket.on('join', function() {
      self.socket.emit('userlist');
    });

    self.socket.on('msg', function(msg) {
      // var msgView = Handlebars.compile($('#v-msg').html());
      $('ul', $el).append(
        '<li>' +
        '<span class="from">' +  msg.from + '</span>' +
        '<span class="text">' + msg.text + '</span>' +
        '</li>'
      );
    });

    self.socket.emit( 'user', { nick: self.nick } );
  };

  self.send = function(text) {
    self.socket.emit( 'msg', { from: self.nick, text: text });
  };
};

var Page = function( $el, events ) {
  var template = Handlebars.compile( $el.html() );
  events = events || [];

  this.render = function( data ) {

    $container.html( template( data ) );

    $container.unbind();

    for ( var i=0; i < events.length; i++ ) {
      $container.on( events[i].type, events[i].el, events[i].action );
    }
  };
};

var me = new Chatter("Anonymous");

var chatPage  = new Page( $('#p-chat'), [ {
  type: 'submit', el: 'form', action: function() {
    var text = $('#msg').val();

    if ( ! text ) { return false }

    $('#msg').val('');
    me.send( text );
    return false;
  }
}
] );

var loginPage = new Page( $('#p-login'), [
  { type: 'submit', el: 'form', action: function() {
    var nick = $('#nick', this).val();

    if ( ! nick ) {
      alert('Missing nickname');
      return false;
    }

    me.nick = nick;
    chatPage.render({ messages: [], nick: me.nick, chatters: [] });
    me.start_chat( $container );
    return false;
  }}
]);




loginPage.render();
