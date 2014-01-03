class Avatar

  constructor: (game) ->
    @position = { x: 64, y: 64 }
    @velocity = { x: 0, y: 0 }
    @speed = 8
    @tileSize = game.tileSize
    @sprite = new Image()
    @setDirection('down')

  update: ->
    @position.x += @velocity.x
    @position.y += @velocity.y

    @velocity.x = 0 if @position.x % @tileSize == 0
    @velocity.y = 0 if @position.y % @tileSize == 0

  draw: (context) ->
    context.drawImage @sprite, @position.x, @position.y, @tileSize, @tileSize

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
    @sprite.src = "images/cecil-#{@direction}.png"
