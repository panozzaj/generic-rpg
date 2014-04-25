class Map.Object.Urn extends Map.Object

  constructor: (@map, data) ->
    super

    @state = 'full'
    @gid = 1701

  drawingData: ->
    _.extend @map.tileDataForGid(@gid),
      tilePosition: @tilePosition

  talk: =>
    if @state == 'full'
      GameEvent.trigger 'dialog', text: """
        You see a mouse jump out of the urn.
      """
      @state = 'empty'
