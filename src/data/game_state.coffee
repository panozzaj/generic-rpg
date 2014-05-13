module.exports = class GameState

  instance = null

  @instance: ->
    instance ?= new GameState

  get: (keyPath) ->
    window.localStorage[keyPath]

  set: (keyPath, value) ->
    window.localStorage[keyPath] = value
