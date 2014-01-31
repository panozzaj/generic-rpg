class Game

  constructor: ->
    @responderManager = new ResponderManager

    @canvas = document.getElementById 'game'
    @context = @canvas.getContext '2d'

    @tileSize = 64

    @mapScreen = new MapScreen @
    @screen = @mapScreen

    GameEvent.on 'battle', @handleBattle

  run: =>
    @update()
    @draw()
    requestAnimFrame @run

  update: ->
    @screen.update()

  draw: ->
    @clearCanvas()
    @screen.draw @context

  clearCanvas: ->
    @context.clearRect 0, 0, @canvas.width, @canvas.height

  onkeydown: (event) =>
    @responderManager.onkeydown(event)

  handleBattle: (e) =>
    @screen = new Battle.Screen @
    @screen.show()

Battle = {}

