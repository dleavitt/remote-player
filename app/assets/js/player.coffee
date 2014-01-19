# Player JS
socket = io.connect location.protocol + '//' + location.host

# TODO: cookie channel
channel = $.cookie 'channel-id-player'

$ ->
  video = $('#video')[0]
  $channel = $('#channel')

  connectChannel = ->
    channel = $channel.val()
    socket.emit 'connect-player', channel: channel if channel
    $.cookie 'channel-id-player', channel, expires: 7

  if channel
    $channel.val(channel)
    connectChannel()

  $('#play').click   -> video.play()
  $('#pause').click  -> video.pause()

  $('#connect').click connectChannel

  socket.on 'cntrl', (data) ->
    return unless data.channel is channel
    switch data.action
      when 'play'   then video.play()
      when 'pause'  then video.pause()
