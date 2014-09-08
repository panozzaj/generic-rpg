GameEvent = require 'src/game_event'
GameState = require 'src/data/game_state'
Actor = require '../actor'

module.exports = class NPC extends Actor

  constructor: (map, { data, @behavior }) ->
    { @name, tileX, tileY } = data
    @tileSize = map.tileSize
    @tilePosition = { x: tileX, y: tileY }

    @name = "#{map.name}:#{@name}"

    @sprite = new Image
    @sprite.src = "assets/images/king.png"
    @direction = 'down'

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

    relevantState.action? GameState.instance()
