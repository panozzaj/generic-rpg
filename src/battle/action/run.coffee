GameEvent = require 'src/game_event'

Action = require 'battle/action'

module.exports = class Run extends Action
  execute: ->
    GameEvent.trigger 'finishedAction'
    GameEvent.trigger 'popScreen'
