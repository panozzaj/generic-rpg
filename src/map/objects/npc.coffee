GameEvent = require 'src/game_event'
GameState = require 'src/data/game_state'
{ MoveAction, Actor } = require '../actor'

module.exports = class NPC extends Actor

  constructor: (@map, { data, @behavior }) ->
    { @name, tileX, tileY } = data
    @setTilePosition tileX, tileY

    @name = "#{map.name}:#{@name}"

    @sprite = new Image
    @sprite.src = "assets/images/king.png"
    @direction = 'down'
    @velocity = { x: 0, y: 0 }
    @speed = 8
    setInterval =>
      @moveInDirection(_.sample(['up', 'down', 'right', 'left']))
      @theMoveAction = new MoveAction @
    , 1000

  update: ->
    @theMoveAction?.update()

  drawingData: ->
    image: @sprite
    sx: 0
    sy: 0
    sw: 16
    sh: 16
    screenPosition: @screenPosition

  talk: =>
    relevantState = _.find @behavior.states, (state) ->
      state.condition GameState.instance()

    relevantState.action? GameState.instance()

  stopMoving: ->
    @velocity = { x: 0, y: 0 }
