String.prototype.ljust = (length) ->
  @ + padStr(@, length)

String.prototype.rjust = (length) ->
  padStr(@, length) + @

padStr = (str, length) ->
  padding = ""
  padLength = length - str.length

  _.times padLength, -> padding += " "

  padding
