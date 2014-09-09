GameEvent = require 'src/game_event'
{ MoveAction, Actor } = require './actor'

module.exports = class Avatar extends Actor

  constructor: (@screen) ->
    @tileSize = @screen.tileSize
    @setTilePosition 20, 9
    @velocity = { x: 0, y: 0 }
    @speed = 8
    @spriteSheet = new Image()
    @spriteSheet.src = "assets/images/cecil-sheet.png"
    @setDirection 'down'
    @directionMappings =
      'down':  0
      'left':  1
      'right': 2
      'up':    3

  # TODO: extract to generic animation handler
  update: ->
    @theMoveAction?.update()


  draw: (context) ->
    context.drawImage(@spriteSheet, @spriteOffset(), 0, 32, 32, @screenPosition.x, @screenPosition.y, @tileSize, @tileSize)

  spriteOffset: ->
    @directionMappings[@direction] * 64

  stopMoving: ->
    @velocity = { x: 0, y: 0 }
    @theMoveAction = null

    if trigger = @screen.map.triggerAt @tilePosition
      GameEvent.trigger 'mapChange', { trigger }

  onkeydown: (event) =>
    return if @isMoving()
    switch event.which
      when 37 # left
        @moveInDirection 'left'
      when 38 # up
        @moveInDirection 'up'
      when 39 # right
        @moveInDirection 'right'
      when 40 # down
        @moveInDirection 'down'
      when 90 # z
        GameEvent.trigger 'talk', facing: @facing()
      when 66 # b
        GameEvent.trigger 'battle'
