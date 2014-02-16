class Battle.Menu

  constructor: ({ @avatar, @select, @cancel }) ->
    @width = 200
    @height = 200
    @actionDescriptions = [
      { name: 'Fight', type: Battle.Action.Attack }
      { name: 'Spell', type: Battle.Action.Spell  }
      { name: 'Run',   type: Battle.Action.Run    }
    ]
    @currentAction = 0
    @cursor = new Image()
    @cursor.src = "images/cursor.png"
    GameEvent.trigger 'pushResponder', responder: @

  destroy: ->
    GameEvent.trigger 'popResponder', responder: @

  actionType: ->
    @actionDescriptions[@currentAction].type

  draw: (context) ->
    @drawBackground context
    @drawActions context
    @drawCursor context

  drawBackground: (context) ->
    context.save()
    context.fillStyle = "#00f"
    context.fillRect 50, 350, @width, @height
    context.restore()

  drawActions: (context) ->
    context.save()
    context.fillStyle = 'white'
    context.font = '30px manaspaceregular'
    _.each @actionDescriptions, (actionDescription, i) ->
      context.fillText actionDescription.name, 80, 400 + 40 * i
    context.restore()

  drawCursor: (context) ->
    context.drawImage @cursor, 45, 380 + 40 * @currentAction, 30, 30

  update: ->

  onkeydown: (event) ->
    switch event.which
      when 38 # up
        @moveCursor -1
      when 40 # down
        @moveCursor 1
      when 90 # z
        @select selectedAction: @actionType()

  moveCursor: (offset) ->
    @currentAction = (@currentAction + @actionDescriptions.length + offset) % @actionDescriptions.length
