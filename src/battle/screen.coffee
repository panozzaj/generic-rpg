class Battle.Screen
  events: ->
    die: @handleDeath

  constructor: (game) ->
    _.each @events(), (handler, eventName) ->
      GameEvent.on eventName, handler

    @width = game.canvas.width
    @height = game.canvas.height

    @avatars = [
      new Battle.Avatar
        name: "Simba"
        position:
          x: 512
          y: 256
      new Battle.Avatar
        name: "Rafiki"
        position:
          x: 512
          y: 128
    ]
    @enemies = [
      new Battle.Enemy(position: { x: 128, y: 128 })
      new Battle.Enemy(position: { x: 128, y: 256 })
    ]
    @statusDisplay = new Battle.StatusDisplay @avatars

    @actionManager = new Battle.Action.Manager

    _.each @avatars, (avatar) =>
      GameEvent.trigger 'enqueue', action:
        type: Battle.Action.ScheduleTurn
        source: avatar
        enemies: @enemies
        executeIn: 0

    _.each @enemies, (enemy) =>
      GameEvent.trigger 'enqueue', action:
        type: Battle.Action.ScheduleTurn
        source: enemy
        enemies: @avatars
        executeIn: 0

  destroy: ->
    _.each @events(), (handler, eventName) ->
      GameEvent.off eventName, handler

  draw: (context) ->
    @drawBackground context
    @drawParty context
    @drawEnemies context
    @drawStatusDisplay context

    @actionManager?.currentAction?.draw? context

    @drawVictoryDialog context if @victoryDialog

  drawBackground: (context) ->
    context.save()
    context.fillStyle = "#9c9"
    context.fillRect 0, 0, @width, @height
    context.restore()

  drawParty: (context) ->
    _.each @avatars, (avatar) -> avatar.draw(context)

  drawEnemies: (context) ->
    _.each @enemies, (enemy) -> enemy.draw(context)

  drawStatusDisplay: (context) ->
    @statusDisplay.draw context

  drawVictoryDialog: (context) ->
    @victoryDialog.draw context

  update: ->
    @actionManager?.update()

  onkeydown: (event) ->

  handleDeath: (event) =>
    switch event.attributes.enemy.constructor.name
      when 'Avatar'
        if _.every(@avatars, (avatar) -> (!avatar.alive()))
          @victoryDialog = new Battle.VictoryDialog text: "Failure!"
          @actionManager.destroy()
          @actionManager = null
      when 'Enemy'
        if _.every(@enemies, (enemy) -> (!enemy.alive()))
          @victoryDialog = new Battle.VictoryDialog text: "Victory!"
          @actionManager.destroy()
          @actionManager = null
