class Map.Avatar

  constructor: (game) ->
    @tileSize = game.tileSize
    @setMapPosition(1, 1)
    @velocity = { x: 0, y: 0 }
    @speed = 8
    @spriteSheet = new Image()
    @spriteSheet.src = "images/cecil-sheet.png"
    @setDirection('down')
    @directionMappings =
      'down':  0
      'left':  1
      'right': 2
      'up':    3
    @frameCounter = 0
    @frame = 1

  update: ->
    if @velocity.x != 0
      @screenPosition.x += @velocity.x
      if @screenPosition.x % @tileSize == 0
        @velocity.x = 0

    if @velocity.y != 0
      @screenPosition.y += @velocity.y
      if @screenPosition.y % @tileSize == 0
        @velocity.y = 0

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

  setMapPosition: (x, y) ->
    @mapPosition = { x: x, y: y }
    @screenPosition = { x: x * @tileSize, y: y * @tileSize }

  moveInDirection: (direction) ->
    @setDirection(direction)
    if direction == 'left'
      @velocity.x = -@speed
      @mapPosition.x -= 1
    else if direction == 'right'
      @velocity.x = @speed
      @mapPosition.x += 1
    else if direction == 'up'
      @velocity.y = -@speed
      @mapPosition.y -= 1
    else if direction == 'down'
      @velocity.y = @speed
      @mapPosition.y += 1

  setDirection: (direction) ->
    @direction = direction

  isMoving: ->
    @velocity.x != 0 || @velocity.y != 0

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
          GameEvent.trigger 'talk', facing: @facing()
      when 66 # b
        if !@isMoving()
          GameEvent.trigger 'battle', random: true

  facing: ->
    { x, y } = @mapPosition
    switch @direction
      when 'left' then x -= 1
      when 'right' then x += 1
      when 'up' then y -= 1
      when 'down' then y += 1
    { x: x, y: y }

  animate: ->
    milliseconds = new Date().getMilliseconds()
    @millisecondsWas ||= milliseconds

    if @millisecondsWas < 500 && milliseconds >= 500
    else if @millisecondsWas >= 500 && milliseconds < 0
      @sprite1.src = "images/cecil-#{@direction}.png"

    @millisecondsWas = milliseconds