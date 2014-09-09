GameEvent = require 'src/game_event'
Actor = require './actor'

class MoveAction
  constructor: (@actor) ->
    # something

  update: ->
    @actor.screenPosition.x += @actor.velocity.x
    @actor.screenPosition.y += @actor.velocity.y

    if @actor.screenPosition.x % @actor.tileSize is 0 and
       @actor.screenPosition.y % @actor.tileSize is 0
      @actor.stopMoving()


module.exports = class Avatar extends Actor

  constructor: (@screen) ->
    @tileSize = @screen.tileSize
    @setTilePosition(20, 9)
    @velocity = { x: 0, y: 0 }
    @speed = 8
    @spriteSheet = new Image()
    @spriteSheet.src = "assets/images/cecil-sheet.png"
    @setDirection('down')
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

  setTilePosition: (x, y) ->
    @tilePosition = { x: x, y: y }
    @screenPosition = { x: x * @tileSize, y: y * @tileSize }

  moveInDirection: (direction) ->
    @setDirection(direction)
    if @screen.map.isWalkable @facing()
      @tilePosition = @facing()
      if direction == 'left'
        @velocity.x = -@speed
      else if direction == 'right'
        @velocity.x = @speed
      else if direction == 'up'
        @velocity.y = -@speed
      else if direction == 'down'
        @velocity.y = @speed
      @theMoveAction = new MoveAction @

  stopMoving: ->
    @velocity = { x: 0, y: 0 }
    @theMoveAction = null

    if trigger = @screen.map.triggerAt @tilePosition
      GameEvent.trigger 'mapChange', { trigger }

  onkeydown: (event) =>
    return if @isMoving()
    switch event.which
      when 37 # left
        @moveInDirection('left')
      when 38 # up
        @moveInDirection('up')
      when 39 # right
        @moveInDirection('right')
      when 40 # down
        @moveInDirection('down')
      when 90 # z
        GameEvent.trigger 'talk', facing: @facing()
      when 66 # b
        GameEvent.trigger 'battle'

  # TODO: extract to generic animation handler
  animate: ->
    milliseconds = new Date().getMilliseconds()
    @millisecondsWas ||= milliseconds

    if @millisecondsWas < 500 && milliseconds >= 500
    else if @millisecondsWas >= 500 && milliseconds < 0
      @sprite1.src = "assets/images/cecil-#{@direction}.png"

    @millisecondsWas = milliseconds
