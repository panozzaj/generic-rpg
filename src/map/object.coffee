class Map.Object
  constructor: (map, data) ->
    { @name, tileX, tileY } = data
    @tileSize = map.tileSize
    @tilePosition = { x: tileX, y: tileY }

    @name = "#{map.name}:#{@name}"
    @loadState()

  states: {}

  update: ->
    # no-op by default

  drawingData: ->
    image: @sprite
    sx: 0
    sy: 0
    sw: 16
    sh: 16
    tilePosition: @tilePosition

  talk: =>
    # no-op by default

  storage: ->
    window.localStorage[@name]

  loadState: ->
    @setState @storage() || _.findKey @states, (state) -> state.initial

  setState: (state) ->
    @state = state
    # give me the new state attributes, minus :initial or :transitions
    @gid = @states[state]?.gid
    window.localStorage[@name] = state

  transitionState: (transition) ->
    newState = @states[@state].transitions[transition]
    if newState
      @setState newState
    else
      console.error "Cannot transition object state from #{@state} via #{transition}"
    newState
