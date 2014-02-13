class Battle.VictoryDialog
  constructor: ({ @text }) ->
    GameEvent.trigger 'pushResponder', responder: @

  update: ->
    # something

  draw: (context) ->
    @drawBackground(context)
    @drawText(context)

  drawBackground: (context) ->
    context.save()
    context.fillStyle = "#33c"
    context.fillRect 50, 50, 500, 100
    context.restore()

  drawText: (context) ->
    context.save()
    context.fillStyle = 'white'
    context.font = '30px manaspaceregular'
    context.fillText @text, 80, 110
    context.restore()

  onkeydown: (event) ->
    switch event.which
      when 90 # z
        GameEvent.trigger 'popResponder', responder: @
        GameEvent.trigger 'popScreen'
