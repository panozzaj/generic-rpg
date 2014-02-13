class Battle.Screen
  events: ->
    fight: @handleFight
    die: @handleDeath
    finishedAction: @finishedAction
    enqueue: @enqueue

  constructor: (game) ->
    @width = game.canvas.width
    @height = game.canvas.height

    @avatar = new Battle.Avatar
    @enemy = new Battle.Enemy
    @statusDisplay = new Battle.StatusDisplay @avatar

    @time = 0
    @actionList = []

    _.each @events(), (handler, eventName) ->
      GameEvent.on eventName, handler

    GameEvent.trigger 'enqueue', action:
      type: Battle.Action.ScheduleTurn
      source: @avatar
      enemies: [@enemy]
      executeIn: 0

    GameEvent.trigger 'enqueue', action:
      type: Battle.Action.ScheduleTurn
      source: @enemy
      enemies: [@avatar]
      executeIn: 0

  destroy: ->
    _.each @events(), (handler, eventName) ->
      GameEvent.off eventName, handler

  draw: (context) ->
    @drawBackground context
    @drawParty context
    @drawEnemies context
    @drawStatusDisplay context

    @currentAction?.draw? context

    @drawVictoryDialog context if @victoryDialog

  drawBackground: (context) ->
    context.save()
    context.fillStyle = "#afa"
    context.fillRect 0, 0, @width, @height
    context.restore()

  drawParty: (context) ->
    @avatar.draw context

  drawEnemies: (context) ->
    @enemy.draw context

  drawStatusDisplay: (context) ->
    @statusDisplay.draw context

  drawVictoryDialog: (context) ->
    @victoryDialog.draw context

  update: ->
    if @currentAction
      @currentAction.update?()
    else
      #console.log "@time: #{@time}" if @time < 100
      action = _.find @actionList, (action) =>
        action.executeAt == @time

      unless @victoryDialog        # don't do actions if battle is over
        if action                  # an action this time tick?
          if action.source.alive() # only do if person is alive
            @currentAction = action
            #console.log "Executing ", @currentAction
            @currentAction.execute()
          else
            @dequeue(action)
        else
          @time += 1

  finishedAction: (event) =>
    @dequeue(@currentAction)
    @currentAction = null

  dequeue: (action) =>
    @actionList.splice @actionList.indexOf(action), 1

  enqueue: (event) =>
    action = event.attributes.action
    action.executeAt = @time + action.executeIn

    @actionList.push new action.type(action)

  onkeydown: (event) ->

  handleDeath: (event) =>
    switch event.attributes.enemy.constructor.name
      when 'Avatar'
        @victoryDialog = new Battle.VictoryDialog text: "Failure!"
      when 'Enemy'
        @victoryDialog = new Battle.VictoryDialog text: "Victory!"
