class Map.Object.Urn extends Map.Object

  constructor: (@map, data) ->
    super

    @gid = 1701

  drawingData: ->
    _.extend @map.tileDataForGid(@gid),
      tilePosition: @tilePosition

  talk: =>
    GameEvent.trigger 'dialog', text: """
      Howdy, this is an urn!
    """
