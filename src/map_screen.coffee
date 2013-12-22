class MapScreen
  constructor: (game) ->
    @tileSize = game.tileSize
    @width = game.canvas.width
    @height = game.canvas.height

    @map = new Map

  draw: (context) ->
    for x in [0...@map.width()]
      for y in [0...@map.height()]
        context.save()
        context.strokeStyle = "#333"
        context.strokeRect x * @tileSize, y * @tileSize, @tileSize, @tileSize
        context.restore()

