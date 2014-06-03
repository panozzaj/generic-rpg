GameEvent = require 'src/game_event'

module.exports = class Dialog
  constructor: (@messages, cb = null) ->
    @canvas = document.createElement('canvas')
    @canvas.width = 1024
    @canvas.height = 200
    @canvas.style.zIndex = 1000
    @canvas.style.position = 'absolute'
    @canvas.style.left = 0
    @canvas.style.top = 0
    document.getElementById('canvases').appendChild(@canvas)

    @messageIndex = 0
    @blinkCounter = 0

  destructor: ->
    document.getElementById('canvases').removeChild(@canvas)

  draw: ->
    context = @canvas.getContext('2d')
    @drawBackground context
    @drawText context
    @drawHasMore context if @hasMore()

  hasMore: ->
    @messageIndex < @messages.length - 1

  update: ->
    @blinkCounter += 1
    if @blinkCounter > 64
      @blinkCounter = 0

  drawHasMore: (context) ->
    if @blinkCounter < 32
      context.save()
      context.fillStyle = 'white'
      context.font = '30px manaspaceregular'
      context.fillText "▼ ", @canvas.width - 40, @canvas.height - 10
      context.restore()

  drawBackground: (context) ->
    context.save()
    context.fillStyle = "#33c"
    context.fillRect 0, 0, 1024, 200
    context.restore()

  drawText: (context) ->
    context.save()
    context.fillStyle = 'white'
    context.font = '30px manaspaceregular'
    lines = @messages[@messageIndex].split("\n")
    _.each lines, (line, i) =>
      context.fillText line, 30, 60 + 40 * i
    context.restore()

  show: (e) =>
    GameEvent.trigger 'pushResponder', responder: @

  onkeydown: (event) =>
    switch event.which
      when 90 # z
        if @messageIndex is @messages.length - 1
          GameEvent.trigger 'popResponder', responder: @
          @destructor()
        else
          @messageIndex++

