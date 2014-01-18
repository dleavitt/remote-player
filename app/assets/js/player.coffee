# Player JS
socket = io.connect 'http://localhost:3000'
$ ->
  video = $('#video')[0]
  $('#play').click   -> video.play()
  $('#pause').click  -> video.pause()

  $channel = $('#channel')
  $('#connect').click ->
    socket.emit 'connect-player', channel: $channel.val() if $channel.val()

  socket.on 'cntrl', (data) ->
    console.log data
    switch data.action
      when 'play'   then video.play()
      when 'pause'  then video.pause()
