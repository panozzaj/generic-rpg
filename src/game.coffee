class Game

  constructor: ->
    @canvas = document.getElementById 'game'
    @context = @canvas.getContext '2d'

    @tileSize = 64

    @avatar = new Avatar @
    @mapMode = new MapMode @

  run: =>
    requestAnimFrame @run
    @update()
    @draw()

  update: ->
    @avatar.update()

  draw: ->
    @clearCanvas()
    @mapMode.draw @context
    @avatar.draw @context

  clearCanvas: ->
    @context.clearRect 0, 0, @canvas.width, @canvas.height

  onkeydown: (event) =>
    return if @avatar.velocity.x || @avatar.velocity.y
    switch event.which
      when 37
        @avatar.velocity.x = -@avatar.speed
      when 38
        @avatar.velocity.y = -@avatar.speed
      when 39
        @avatar.velocity.x = @avatar.speed
      when 40
        @avatar.velocity.y = @avatar.speed

