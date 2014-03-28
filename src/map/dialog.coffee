class Map.Dialog
  constructor: (@text) ->
    @canvas = document.createElement('canvas')
    @canvas.width = 1024
    @canvas.height = 200
    @canvas.style.zIndex = 1000
    @canvas.style.position = 'absolute'
    @canvas.style.left = 0
    @canvas.style.top = 0
    document.getElementById('canvases').appendChild(@canvas)

  destructor: ->
    document.getElementById('canvases').removeChild(@canvas)

  draw: ->
    context = @canvas.getContext('2d')
    @drawBackground(context)
    @drawText(context)

  drawBackground: (context) ->
    context.save()
    context.fillStyle = "#33c"
    context.fillRect 0, 0, 1024, 200
    context.restore()

  drawText: (context) ->
    context.save()
    context.fillStyle = 'white'
    context.font = '30px manaspaceregular'
    lines = @text.split("\n")
    _.each lines, (line, i) =>
      context.fillText line, 30, 60 + 40 * i
    context.restore()

  show: (e) =>
    GameEvent.trigger 'pushResponder', responder: @

  onkeydown: (event) =>
    switch event.which
      when 90 # z
        GameEvent.trigger 'popResponder', responder: @
        @destructor()


