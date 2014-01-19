# Controller JS
socket = io.connect location.protocol + '//' + location.host
channel = $.cookie 'channel-id-controller'

randString = (len=5) -> Math.random().toString(36).substring(5, 5 + len)

displayChannel = -> $('.channel-id').text channel

resetChannel = ->
  channel = "#{randString(3)}-#{randString(3)}"
  $.cookie 'channel-id-controller', channel, expires: 7
  displayChannel()

$ ->
  if channel then displayChannel() else resetChannel()

  $('#reset-channel').click resetChannel
  $('#play').click  -> socket.emit 'cntrl', action: 'play', channel: channel
  $('#pause').click -> socket.emit 'cntrl', action: 'pause', channel: channel
