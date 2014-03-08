class Game

  constructor: ->
    @responderManager = new ResponderManager
    @screenManager = new ScreenManager
    @audioManager = new AudioManager

    @canvas = document.getElementById 'game'
    @context = @canvas.getContext '2d'
    @context.imageSmoothingEnabled = false

    @mapScreen = new Map.Screen @
    @screenManager.push @mapScreen

    @party = [
      new Model.Hero(name: 'Simba'),
      new Model.Hero(name: 'Rafiki')
    ]

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
    Q.allSettled([
      @audioManager.play('battle_start.wav'),
      @mapScreen.handleBlur()
    ]).then (val) =>
      @screenManager.push(new Battle.Screen game: @, party: @party)


# Namespace creation / setup
# TODO: Move this somewhere more intelligent
Battle = {}
Map = {}
Model = {}

