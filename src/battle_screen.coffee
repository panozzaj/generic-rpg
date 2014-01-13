class BattleScreen
  constructor: (game) ->
    @width = game.canvas.width
    @height = game.canvas.height

    @avatar = new BattleAvatar
    @enemy = new BattleEnemy

  draw: (context) ->
    @drawBackground context
    @drawParty context
    @drawEnemies context

  drawBackground: (context) ->
    context.save()
    context.fillStyle = "#afa"
    context.fillRect 0, 0, @width, @height
    context.restore()

  drawParty: (context) ->
    @avatar.draw context

  drawEnemies: (context) ->
    @enemy.draw context

  update: ->
    # TODO
