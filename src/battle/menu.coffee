class Battle.Menu

  constructor: ->
    @width = 200
    @height = 200
    @actions = ['Fight', 'Magic', 'Defend', 'Run']
    @currentAction = 0
    @cursor = new Image()
    @cursor.src = "images/cursor.png"

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
    _.each @actions, (action, i) ->
      context.fillText action, 80, 400 + 40 * i
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
        @performCurrentAction()

  moveCursor: (offset) ->
    @currentAction = (@currentAction + @actions.length + offset) % @actions.length

  performCurrentAction: ->
    switch @currentAction
      when 0
        GameEvent.trigger 'fight'
      when 3
        GameEvent.trigger 'popScreen'
