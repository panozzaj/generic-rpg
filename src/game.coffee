class Game

  constructor: ->
    @canvas = document.getElementById 'game'
    @context = @canvas.getContext '2d'

    @tileSize = 64

    @avatar = new Avatar

  run: =>
    @update()
    @draw()
    requestAnimFrame @run

  update: ->
    @avatar.update()

  draw: ->
    @clearCanvas()
    @drawGrid()
    @avatar.draw @context

  clearCanvas: ->
    @context.clearRect 0, 0, @canvas.width, @canvas.height

  drawGrid: ->
    for x in [0..@canvas.width/@tileSize]
      for y in [0..@canvas.height/@tileSize]
        @context.save()
        @context.strokeStyle = "#333"
        @context.strokeRect x * @tileSize, y * @tileSize, @tileSize, @tileSize
        @context.restore()

  onkeydown: (event) =>
    switch event.which
      when 37
        @avatar.velocity.x = -@avatar.speed
      when 38
        @avatar.velocity.y = -@avatar.speed
      when 39
        @avatar.velocity.x = @avatar.speed
      when 40
        @avatar.velocity.y = @avatar.speed

