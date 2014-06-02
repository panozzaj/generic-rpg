GameEvent = require 'src/game_event'

Action = require './base'
Attack = require './attack'

MenuAction = require 'battle/menu/action'

module.exports = class ScheduleTurn extends Action
  execute: ->
    switch @source.constructor.name
      when "Avatar"
        GameEvent.trigger 'enqueue', action:
          type: MenuAction
          source: @source
          executeIn: 10

      when "Enemy"
        GameEvent.trigger 'enqueue', action:
          type: Attack
          source: @source
          target: _.sample @battle.avatars
          executeIn: 10

    GameEvent.trigger 'finishedAction'
