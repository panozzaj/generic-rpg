class Map.NPC

  constructor: (map, data) ->
    { @name, tileX, tileY } = data
    @tileSize = map.tileSize
    @setTilePosition(tileX, tileY)

    GameEvent.on 'talk', @talk

  update: ->
    # no-op

  draw: (context) ->
    context.save()
    context.fillStyle = "#eee"
    context.fillRect @screenPosition.x, @screenPosition.y, @tileSize, @tileSize
    context.restore()

  setTilePosition: (x, y) ->
    @tilePosition = { x: x, y: y }
    @screenPosition = { x: x * @tileSize, y: y * @tileSize }

  talk: (e) =>
    if _.isEqual(e.attributes.facing, @tilePosition)
      GameEvent.trigger 'dialog', text: """
        Hello Simba!
        This is your destiny...
      """, npcScreenPosition: @screenPosition
