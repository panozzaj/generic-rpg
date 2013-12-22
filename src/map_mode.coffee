class MapMode
  constructor: (game) ->
    @tileSize = game.tileSize
    @width = game.canvas.width
    @height = game.canvas.height

  draw: (context) ->
    for x in [0..(@width / @tileSize)]
      for y in [0..(@height / @tileSize)]
        context.save()
        context.strokeStyle = "#333"
        context.strokeRect x * @tileSize, y * @tileSize, @tileSize, @tileSize
        context.restore()
