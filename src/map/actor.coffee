GameEvent = require 'src/game_event'

class MoveAction
  constructor: (@actor) ->
    # something

  update: ->
    @actor.screenPosition.x += @actor.velocity.x
    @actor.screenPosition.y += @actor.velocity.y

    if @actor.screenPosition.x % @actor.map.tileSize is 0 and
       @actor.screenPosition.y % @actor.map.tileSize is 0
      @actor.stopMoving()


class Actor
  # returns the tile that the Actor is facing
  facing: ->
    { x, y } = @tilePosition
    switch @direction
      when 'left'  then x -= 1
      when 'right' then x += 1
      when 'up'    then y -= 1
      when 'down'  then y += 1
    { x, y }

  isMoving: ->
    @velocity.x != 0 || @velocity.y != 0

  setDirection: (direction) ->
    @direction = direction

  moveInDirection: (direction) ->
    @setDirection direction

    movePromise = Q.defer()

    GameEvent.trigger 'move',
      newPosition: @facing()
      movePromise: movePromise

    movePromise.promise
    .then =>
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
    .fail ->
      console.warn 'failure'

  setTilePosition: (x, y) ->
    @tilePosition = { x: x, y: y }
    @screenPosition = { x: x * @map.tileSize, y: y * @map.tileSize }


module.exports = { MoveAction, Actor }
