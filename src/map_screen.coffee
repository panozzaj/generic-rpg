class MapScreen
  constructor: (game) ->
    @tileSize = game.tileSize
    @width = game.canvas.width
    @height = game.canvas.height

    @map = new Map @

  draw: (context) ->
    @map.draw context

