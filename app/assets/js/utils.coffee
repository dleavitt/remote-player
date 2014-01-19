window.randKey = (len = 5) ->
  chars = 'ABCDEFGHJKLMNPQRTUVWXY346789'
  charsLen = chars.length
  (chars[Math.floor(Math.random() * charsLen)] for i in [0..len]).join('')

