class Map.Treasure

  constructor: (map, data) ->
    { @name, tileX, tileY } = data
    @tileSize = map.tileSize
    @setTilePosition(tileX, tileY)

    @sprite = new Image
    @sprite.src = "assets/images/king.png"

  update: ->
    # no-op

  draw: (context) ->
    context.save()
    context.drawImage @sprite, 0, 0, 16, 16, \
      @screenPosition.x, @screenPosition.y, @tileSize, @tileSize
    context.restore()

  setTilePosition: (x, y) ->
    @tilePosition = { x: x, y: y }
    @screenPosition = { x: x * @tileSize, y: y * @tileSize }

  talk: =>
    GameEvent.trigger 'dialog', text: """
      Howdy, this is a treasure chest!
    """
