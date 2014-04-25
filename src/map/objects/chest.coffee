class Map.Object.Chest extends Map.Object

  constructor: (@map, data) ->
    super
    @state = 'closed'
    @gid = 1703

  drawingData: ->
    _.extend @map.tileDataForGid(@gid),
      tilePosition: @tilePosition

  talk: ->
    if @state == 'closed'
      GameEvent.trigger 'dialog', text: """
        You got <treasure>!
      """
      @gid = 1702
      @state = 'open'
    else
      GameEvent.trigger 'dialog', text: """
        The chest is empty... :(
      """
