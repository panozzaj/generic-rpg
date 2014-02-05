class Battle.Screen
  constructor: (game) ->
    @width = game.canvas.width
    @height = game.canvas.height

    @avatar = new Battle.Avatar
    @enemy = new Battle.Enemy
    @menu = new Battle.Menu
    @statusDisplay = new Battle.StatusDisplay @avatar

    GameEvent.on 'fight', @handleFight

  draw: (context) ->
    @drawBackground context
    @drawParty context
    @drawEnemies context
    @drawMenu context
    @drawStatusDisplay context

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

  update: ->
    # TODO

  onkeydown: (event) ->
    @menu.onkeydown(event)

  handleFight: =>
    effectiveDamage = Math.round(@avatar.stats.damage * (Math.random() / 2 + 0.75))
    @enemy.stats.hp.current -= effectiveDamage
    console.log effectiveDamage, @enemy.stats.hp
