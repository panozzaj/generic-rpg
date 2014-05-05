class Map.Object.Chest extends Map.Object

  constructor: (@map, data) ->
    super
    @name = "#{@map.name}:#{@name}"
    @loadState()

  loadState: ->
    if window.localStorage[@name] == 'open'
      @setState 'open', 1702
    else
      @setState 'closed', 1703

  setState: (newState, newGid) ->
    @state = newState
    @gid = newGid
    window.localStorage[@name] = newState

  drawingData: ->
    _.extend @map.tileDataForGid(@gid),
      tilePosition: @tilePosition

  talk: ->
    if @state == 'closed'
      GameEvent.trigger 'dialog', text: """
        You got <treasure>!
      """
      @setState 'open', 1702
    else
      GameEvent.trigger 'dialog', text: """
        The chest is empty... :(
      """

