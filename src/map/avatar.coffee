class Map.Avatar

  constructor: (@screen) ->
    @tileSize = @screen.tileSize
    @setTilePosition(30, 30)
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
    @frameCounter = 0
    @frame = 1

  # TODO: extract to generic animation handler
  update: ->
    if @velocity.x != 0
      @screenPosition.x += @velocity.x
      @stopMoving() if @screenPosition.x % @tileSize == 0

    if @velocity.y != 0
      @screenPosition.y += @velocity.y
      @stopMoving() if @screenPosition.y % @tileSize == 0

    # animation frame counter
    if @frameCounter > 8
      @frameCounter = 0
    if @frameCounter > 4
      @frame = 0
    else
      @frame = 1
    @frameCounter += 1

  draw: (context) ->
    context.drawImage(@spriteSheet, @spriteOffset(), 0, 32, 32, @screenPosition.x, @screenPosition.y, @tileSize, @tileSize)

  spriteOffset: ->
    @directionMappings[@direction] * 64 + @frame * 32

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

  setDirection: (direction) ->
    @direction = direction

  isMoving: ->
    @velocity.x != 0 || @velocity.y != 0

  stopMoving: ->
    @velocity = { x: 0, y: 0 }
    if trigger = @screen.map.triggerAt @tilePosition
      GameEvent.trigger 'mapChange', { trigger }

  onkeydown: (event) =>
    return if @velocity.x || @velocity.y
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
        if !@isMoving()
          console.log @screen.map.contents @facing()
          # legacy -- NPCs should move into map layer
          GameEvent.trigger 'talk', facing: @facing()
      when 66 #
        if !@isMoving()
          GameEvent.trigger 'battle'

  facing: ->
    { x, y } = @tilePosition
    switch @direction
      when 'left'  then x -= 1
      when 'right' then x += 1
      when 'up'    then y -= 1
      when 'down'  then y += 1
    { x, y }

  # TODO: extract to generic animation handler
  animate: ->
    milliseconds = new Date().getMilliseconds()
    @millisecondsWas ||= milliseconds

    if @millisecondsWas < 500 && milliseconds >= 500
    else if @millisecondsWas >= 500 && milliseconds < 0
      @sprite1.src = "assets/images/cecil-#{@direction}.png"

    @millisecondsWas = milliseconds

