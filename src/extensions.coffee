String.prototype.ljust = (length) ->
  @ + padStr(@, length)

String.prototype.rjust = (length) ->
  padStr(@, length) + @

padStr = (str, length) ->
  padding = ""
  padLength = length - str.length

  _.times padLength, -> padding += " "

  padding

CanvasRenderingContext2D.prototype.fillRoundRect = (args...) ->
  @roundRect args...
  @fill()

CanvasRenderingContext2D.prototype.strokeRoundRect = (args...) ->
  @roundRect args...
  @stroke()

CanvasRenderingContext2D.prototype.roundRect = (x, y, width, height, radius) ->
  topLeft = [x, y]
  topLeftArcStart = [x, y + radius]
  topLeftArcEnd = [x + radius, y]

  topRight = [x + width, y]
  topRightArcStart = [x + width - radius, y]
  topRightArcEnd = [x + width, y + radius]

  bottomRight = [x + width, y + height]
  bottomRightArcStart = [x + width, y + height - radius]
  bottomRightArcEnd = [x + width - radius, y + height]

  bottomLeft = [x, y + height]
  bottomLeftArcStart = [x + radius, y + height]
  bottomLeftArcEnd = [x, y + height - radius]

  @beginPath()
  @moveTo topLeftArcEnd...

  @lineTo topRightArcStart...
  @quadraticCurveTo topRight..., topRightArcEnd..., radius

  @lineTo bottomRightArcStart...
  @quadraticCurveTo bottomRight..., bottomRightArcEnd..., radius

  @lineTo bottomLeftArcStart...
  @quadraticCurveTo bottomLeft..., bottomLeftArcEnd..., radius

  @lineTo topLeftArcStart...
  @quadraticCurveTo topLeft..., topLeftArcEnd..., radius
  @closePath()
