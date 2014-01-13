class BattleScreen
  constructor: (game) ->
    @width = game.canvas.width
    @height = game.canvas.height

    @avatar = new BattleAvatar

  draw: (context) ->
    @drawBackground context
    @drawParty context

  drawBackground: (context) ->
    context.save()
    context.fillStyle = "#afa"
    context.fillRect 0, 0, @width, @height
    context.restore()

  drawParty: (context) ->
    @avatar.draw context

  update: ->
    # TODO
