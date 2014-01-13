class BattleScreen
  constructor: (game) ->
    @width = game.canvas.width
    @height = game.canvas.height

  draw: (context) ->
    context.save()
    context.fillStyle = "#afa"
    context.fillRect 0, 0, @width, @height
    context.restore()

  update: ->
    # TODO
