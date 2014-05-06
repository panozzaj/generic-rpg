class Map.Object.Chest extends Map.Object

  states:
    opened:
      gid: 1702
    closed:
      initial: true
      transitions:
        open: 'opened'
      gid: 1703

  constructor: (@map, data) ->
    super

  drawingData: ->
    _.extend @map.tileDataForGid(@gid),
      tilePosition: @tilePosition

  talk: ->
    if @state == 'closed'
      if @transitionState 'open'
        GameEvent.trigger 'dialog', text: """
          You got <treasure>!
        """
    else
      GameEvent.trigger 'dialog', text: """
        The chest is empty... :(
      """
