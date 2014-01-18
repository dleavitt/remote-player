# Controller JS
socket = io.connect 'http://localhost:3000'
$ ->
  channel = Math.round(Math.random() * 10000)
  console.log channel
  $('#play').click  -> socket.emit 'cntrl', action: 'play', channel: channel
  $('#pause').click -> socket.emit 'cntrl', action: 'pause', channel: channel
