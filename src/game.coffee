class Game

  constructor: ->
    @canvas = document.getElementById 'game'
    @context = @canvas.getContext '2d'

    @tileSize = 64

    @avatar = new Avatar @
    @mapMode = new MapScreen @

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
    @avatar.onkeydown(event)
