module.exports = class Actor
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
