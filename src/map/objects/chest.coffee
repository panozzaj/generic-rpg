class Map.Object.Chest extends Map.Object

  constructor: (@map, data) ->
    super

    @gid = 1703

  drawingData: ->
    _.extend @map.tileDataForGid(@gid),
      tilePosition: @tilePosition

  talk: =>
    GameEvent.trigger 'dialog', text: """
      Howdy, this is a chest!
    """
