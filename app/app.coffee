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
  # app.set 'view engine', 'jade'
  app.use express.static("#{__dirname}/../public")
  # app.use express.favicon()
  # app.use express.logger('dev')
  # app.use express.bodyParser()
  # app.use express.methodOverride()
  # app.use require('connect-assets')
  #   src: "#{__dirname}/assets"
  #   helperContext: app.locals
  # app.use app.router

app.configure 'development', ->
  app.use express.errorHandler()

# console.log __dirname + '/index.html'
app.get '/', (req, res) ->
  res.render 'index', view: 'index'

io.sockets.on 'connection', (socket) ->
  socket.emit 'news', hello: 'world'
  socket.on 'my other event', (data) ->
    console.log(data);


server.listen app.get('port')
