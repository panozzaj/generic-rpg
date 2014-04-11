class Map.Object
  constructor: (map, data) ->
    { @name, tileX, tileY } = data
    @tileSize = map.tileSize
    @setTilePosition(tileX, tileY)

  update: ->
    # no-op by default

  draw: (context) ->
    context.save()
    context.drawImage @sprite, 0, 0, 16, 16, \
      @screenPosition.x, @screenPosition.y, @tileSize, @tileSize
    context.restore()

  setTilePosition: (x, y) ->
    @tilePosition = { x: x, y: y }
    @screenPosition = { x: x * @tileSize, y: y * @tileSize }

  talk: =>
    # no-op by default
