class Game

  constructor: ->
    @responderManager = new ResponderManager
    @screenManager = new ScreenManager

    @canvas = document.getElementById 'game'
    @context = @canvas.getContext '2d'

    @tileSize = 64

    @mapScreen = new MapScreen @
    @screenManager.push @mapScreen

    GameEvent.on 'battle', @handleBattle
    GameEvent.on 'popScreen', =>
      @screenManager.pop()

  destructor: =>
    console.log 'destructed Game'

  run: =>
    @update()
    @draw()
    requestAnimFrame @run

  update: ->
    @screenManager.activeScreen().update()

  draw: ->
    @clearCanvas()
    @screenManager.activeScreen().draw @context

  clearCanvas: ->
    @context.clearRect 0, 0, @canvas.width, @canvas.height

  onkeydown: (event) =>
    @responderManager.onkeydown(event)

  handleBattle: (e) =>
    @screenManager.push(new Battle.Screen @)

# Namespace creation / setup
# TODO: Move this somewhere more intelligent
Battle = {}
Battle.Action = {}
