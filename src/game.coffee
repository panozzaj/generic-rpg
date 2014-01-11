class Game

  constructor: ->
    @canvas = document.getElementById 'game'
    @context = @canvas.getContext '2d'

    @tileSize = 64

    @avatar = new Avatar @
    @mapMode = new MapScreen @
    @npc = new NPC @

  run: =>
    @update()
    @draw()
    requestAnimFrame @run

  update: ->
    @avatar.update()

  draw: ->
    @clearCanvas()
    @mapMode.draw @context
    @avatar.draw @context
    @npc.draw @context

  clearCanvas: ->
    @context.clearRect 0, 0, @canvas.width, @canvas.height

  onkeydown: (event) =>
    @avatar.onkeydown(event)
