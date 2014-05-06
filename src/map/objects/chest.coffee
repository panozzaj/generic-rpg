class Map.Object.Chest extends Map.Object

  states:
    opened:
      gid: 1702
    closed:
      initial: true
      gid: 1703
      #transitions:
      #  open: 'opened'

  constructor: (@map, data) ->
    super
    @name = "#{@map.name}:#{@name}"
    @loadState()

  storage: ->
    window.localStorage[@name]

  loadState: ->
    if @storage() == 'opened'
      @setState 'opened'
    else
      @setState 'closed'

  setState: (state) ->
    @state = state
    @gid = @states[state].gid
    window.localStorage[@name] = state

  drawingData: ->
    _.extend @map.tileDataForGid(@gid),
      tilePosition: @tilePosition

  talk: ->
    if @state == 'closed'
      GameEvent.trigger 'dialog', text: """
        You got <treasure>!
      """
      @setState 'opened'
    else
      GameEvent.trigger 'dialog', text: """
        The chest is empty... :(
      """

