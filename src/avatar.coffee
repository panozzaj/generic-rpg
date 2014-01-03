class Avatar

  constructor: (game) ->
    @position = { x: 64, y: 64 }
    @velocity = { x: 0, y: 0 }
    @speed = 8
    @tileSize = game.tileSize
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
    @position.x += @velocity.x
    @position.y += @velocity.y

    @velocity.x = 0 if @position.x % @tileSize == 0
    @velocity.y = 0 if @position.y % @tileSize == 0

    if @frameCounter > 8
      @frameCounter = 0
    if @frameCounter > 4
      @frame = 0
    else
      @frame = 1
    @frameCounter += 1

  draw: (context) ->
    context.drawImage(@spriteSheet, @spriteOffset(), 0, 32, 32, @position.x, @position.y, @tileSize, @tileSize)

  spriteOffset: ->
    @directionMappings[@direction] * 64 + @frame * 32

  onkeydown: (event) =>
    return if @velocity.x || @velocity.y
    switch event.which
      when 37
        @velocity.x = -@speed
        @setDirection('left')
      when 38
        @velocity.y = -@speed
        @setDirection('up')
      when 39
        @velocity.x = @speed
        @setDirection('right')
      when 40
        @velocity.y = @speed
        @setDirection('down')

  setDirection: (direction) ->
    @direction = direction

  animate: ->
    milliseconds = new Date().getMilliseconds()
    @millisecondsWas ||= milliseconds

    if @millisecondsWas < 500 && milliseconds >= 500
    else if @millisecondsWas >= 500 && milliseconds < 0
      @sprite1.src = "images/cecil-#{@direction}.png"

    @millisecondsWas = milliseconds

