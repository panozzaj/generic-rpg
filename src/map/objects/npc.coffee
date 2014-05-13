GameEvent = require 'src/game_event'
GameState = require 'src/data/game_state'

module.exports = class NPC

  constructor: (map, { data, @behavior }) ->
    { @name, tileX, tileY } = data
    @tileSize = map.tileSize
    @tilePosition = { x: tileX, y: tileY }

    @name = "#{map.name}:#{@name}"

    @sprite = new Image
    @sprite.src = "assets/images/king.png"

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
    relevantState = _.find @behavior.states, (state) ->
      state.condition GameState.instance()
    GameEvent.trigger 'dialog', text: relevantState.dialog
    relevantState.action? GameState.instance()


