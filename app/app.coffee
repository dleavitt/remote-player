express = require 'express'
app = express()
server = require('http').createServer(app)
io = require('socket.io').listen(server)

app.configure ->
  port = process.env.PORT || 3000
  if process.argv.indexOf('-p') >= 0
    port = process.argv[process.argv.indexOf('-p') + 1]

  app.set 'port', port
  app.set 'views', "#{__dirname}/views"
  app.set 'view engine', 'jade'
  app.use express.static("#{__dirname}/../public")
  app.use express.favicon()
  app.use express.logger('dev')
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use require('connect-assets')
    src: "#{__dirname}/assets"
    helperContext: app.locals

app.configure 'development', ->
  app.use express.errorHandler()

app.get '/player', (req, res) -> res.render 'player', view: 'player'
app.get '/controller', (req, res) -> res.render 'controller', view: 'controller'

io.sockets.on 'connection', (socket) ->
  socket.on 'connect-player', (data) ->
    for room, state of socket.manager.roomClients[socket.id]
      if room[0] == '/' and state
        channel = room.substring(1)
        console.log "player disconnected from channel #{channel}"
        socket.leave(channel)

    console.log "player connected to channel #{data.channel}"
    socket.join(data.channel)
  socket.on 'cntrl', (data) ->
    io.sockets.in(data.channel).emit 'cntrl', data

server.listen app.get('port')
