ScreenManager = require './screen_manager'
MapScreen = require './map/screen'

module.exports = class Game

  constructor: ->

    @screenManager = new ScreenManager

    @canvas = document.getElementById 'game'
    @canvas.width = 1024
    @canvas.height = 640
    @context = @canvas.getContext '2d'
    @context.imageSmoothingEnabled = false

    @mapScreen = new MapScreen @
    @screenManager.push @mapScreen

  run: ->
    @draw()
    @update()
    requestAnimFrame @run

  update: ->
    @screenManager.activeScreen().update()

  run: ->
    @clearCanvas()
    @screenManager.activeScreen().draw @context

  clearCanvas: ->
    @context.clearRect 0, 0, @canvas.width, @canvas.height
