console.log('--- Chatter Server ---');

var io = require('socket.io').listen(3100);

var chatters = [];

io.sockets.on('connection', function (socket) {

  socket.on('userlist', function() {
    console.dir( chatters );
    socket.emit('userlist', chatters);
  });

  socket.on('user', function(user) {
    console.log(user);

    socket.set('name', user.nick);
    chatters.push( user.nick );
    io.sockets.emit('userlist', chatters );
  });

  socket.on('msg', function (data) {
    io.sockets.emit('msg', data);
    console.log(data);
  });

  socket.on('disconnect', function() {
    socket.get('name', function(nick) {
      chatters = chatters.filter(function(el) { el !== nick } );
      socket.broadcast.emit('leave', nick);
    });
  });
});



console.log('--- Chatter Server Ready ---');
