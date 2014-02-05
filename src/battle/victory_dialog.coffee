class Battle.VictoryDialog
  constructor: (@battleScreen) ->
    GameEvent.trigger 'pushResponder', responder: @

  update: ->
    # something

  draw: (context) ->
    @drawBackground(context)
    @drawText(context)

  drawBackground: (context) ->
    context.save()
    context.fillStyle = "#33c"
    context.fillRect 50, 50, 500, 250
    context.restore()

  drawText: (context) ->
    context.save()
    context.fillStyle = 'white'
    context.font = '30px manaspaceregular'
    context.fillText "Victory!", 80, 110
    context.restore()

  onkeydown: (event) ->
    switch event.which
      when 90 # z
        GameEvent.trigger 'popResponder', responder: @
        GameEvent.trigger 'popScreen'
