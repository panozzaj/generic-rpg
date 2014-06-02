GameEvent = require 'src/game_event'

ResponderManager = require './responder_manager'
ScreenManager = require './screen_manager'
AudioManager = require './audio_manager'
Hero = require './models/hero'

BlurEffect = require 'effect/blur'

BattleScreen = require 'battle/screen'
MapScreen = require 'map/screen'

module.exports = class Game

  constructor: ->
    @responderManager = new ResponderManager
    @screenManager = new ScreenManager
    @audioManager = new AudioManager

    @canvas = document.getElementById 'game'
    @canvas.width = 1024
    @canvas.height = 640
    @context = @canvas.getContext '2d'
    @context.imageSmoothingEnabled = false

    @mapScreen = new MapScreen @
    @screenManager.push @mapScreen

    @party = [
      new Hero(name: 'Simba'),
      new Hero(name: 'Rafiki')
    ]

    GameEvent.on 'battle', @handleBattle

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
      AudioManager.playSound 'battle_start.wav',
      new BlurEffect(@canvas)
    ]).then (val) =>
      @screenManager.push new BattleScreen(game: @, party: @party)
