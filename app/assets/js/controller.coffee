#= require utils

# Controller JS
socket = io.connect location.protocol + '//' + location.host
channel = $.cookie 'channel-id-controller'

displayChannel = -> $('.channel-id').text channel

resetChannel = ->
  channel = randKey()
  $.cookie 'channel-id-controller', channel, expires: 7
  displayChannel()

$ ->
  if channel then displayChannel() else resetChannel()

  $('#reset-channel').click resetChannel
  $('#play').click  -> socket.emit 'cntrl', action: 'play', channel: channel
  $('#pause').click -> socket.emit 'cntrl', action: 'pause', channel: channel
