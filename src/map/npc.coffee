class Map.NPC

  constructor: (game) ->
    @tileSize = game.tileSize
    @setMapPosition(4, 5)

    GameEvent.on 'talk', @talk

  update: ->
    # no-op

  draw: (context) ->
    context.save()
    context.fillStyle = "#eee"
    context.fillRect @screenPosition.x, @screenPosition.y, @tileSize, @tileSize
    context.restore()

  setMapPosition: (x, y) ->
    @mapPosition = { x: x, y: y }
    @screenPosition = { x: x * @tileSize, y: y * @tileSize }

  talk: (e) =>
    if _.isEqual(e.attributes.facing, @mapPosition)
      GameEvent.trigger 'dialog', text: """
        Hello Simba!
        This is your destiny...
      """
