GameEvent = require 'src/game_event'
Action = require './base'

module.exports = class Run extends Action
  execute: ->
    GameEvent.trigger 'finishedAction'
    GameEvent.trigger 'popScreen'
