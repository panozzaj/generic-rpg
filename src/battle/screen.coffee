class Battle.Screen
  events: ->
    fight: @handleFight
    die: @handleDeath

  constructor: (game) ->
    @width = game.canvas.width
    @height = game.canvas.height

    @avatar = new Battle.Avatar
    @enemy = new Battle.Enemy
    @menu = new Battle.Menu
    @statusDisplay = new Battle.StatusDisplay @avatar

    _.each @events(), (handler, eventName) ->
      GameEvent.on eventName, handler

  destroy: ->
    _.each @events(), (handler, eventName) ->
      GameEvent.off eventName, handler

  draw: (context) ->
    @drawBackground context
    @drawParty context
    @drawEnemies context
    @drawMenu context
    @drawStatusDisplay context

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

  drawMenu: (context) ->
    @menu.draw context

  drawStatusDisplay: (context) ->
    @statusDisplay.draw context

  drawVictoryDialog: (context) ->
    @victoryDialog.draw context

  update: ->
    @enemy.update()

  onkeydown: (event) ->
    @menu.onkeydown(event)

  handleFight: =>
    effectiveDamage = Math.round(@avatar.stats.damage * (Math.random() / 2 + 0.75))
    @enemy.takeDamage(effectiveDamage)

  handleDeath: (event) =>
    @victoryDialog = new Battle.VictoryDialog @

