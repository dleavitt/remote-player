# Controller JS
socket = io.connect location.protocol + '//' + location.host
$ ->
  channel = Math.round(Math.random() * 10000)
  console.log channel
  $('#play').click  -> socket.emit 'cntrl', action: 'play', channel: channel
  $('#pause').click -> socket.emit 'cntrl', action: 'pause', channel: channel
