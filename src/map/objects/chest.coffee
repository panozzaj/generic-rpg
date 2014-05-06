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
    @name = "#{@map.name}:#{@name}"
    @loadState()

  storage: ->
    window.localStorage[@name]

  loadState: ->
    @setState @storage() || _.findKey @states, (state) -> state.initial


  setState: (state) ->
    @state = state
    # give me the new state attributes, minus :initial or :transitions
    @gid = @states[state].gid
    window.localStorage[@name] = state

  transitionState: (transition) ->
    newState = @states[@state].transitions[transition]
    if newState
      @setState newState
    else
      console.error "Cannot transition object state from #{@state} via #{transition}"
    newState

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

