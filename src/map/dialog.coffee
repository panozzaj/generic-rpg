class Map.Dialog
  constructor: (game) ->
    @alive = false
    GameEvent.on 'dialog', @show

  update: ->
    # something

  draw: (context) ->
    if @alive
      @drawBackground(context)
      @drawText(context)

  drawBackground: (context) ->
    context.save()
    context.fillStyle = "#33c"
    context.fillRect @x, @y, 500, 250
    context.restore()

  drawText: (context) ->
    context.save()
    context.fillStyle = 'white'
    context.font = '30px manaspaceregular'
    lines = @text.split("\n")
    _.each lines, (line, i) =>
      context.fillText line, @x + 30, @y + 60 + 40 * i
    context.restore()

  show: (e) =>
    @alive = true
    @text = e.attributes.text
    @positionBasedOn e.attributes.npcScreenPosition
    GameEvent.trigger 'pushResponder', responder: @

  positionBasedOn: ({ x, y }) ->
    @x = x - 200
    @y = y - 255

  onkeydown: (event) ->
    switch event.which
      when 90 # z
        @alive = false
        GameEvent.trigger 'popResponder', responder: @
