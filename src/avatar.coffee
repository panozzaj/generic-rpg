class Avatar

  constructor: (game) ->
    @position = { x: 64, y: 64 }
    @velocity = { x: 0, y: 0 }
    @speed = 8
    @tileSize = game.tileSize

  update: ->
    @position.x += @velocity.x
    @position.y += @velocity.y

    @velocity.x = 0 if @position.x % @tileSize == 0
    @velocity.y = 0 if @position.y % @tileSize == 0

  draw: (context) ->
    context.save()
    context.fillStyle = "#f00"
    context.fillRect @position.x, @position.y, @tileSize, @tileSize
    context.restore()

  onkeydown: (event) =>
    return if @velocity.x || @velocity.y
    switch event.which
      when 37
        @velocity.x = -@speed
      when 38
        @velocity.y = -@speed
      when 39
        @velocity.x = @speed
      when 40
        @velocity.y = @speed
