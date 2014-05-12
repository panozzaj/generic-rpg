GameEvent = require 'src/game_event'

Avatar = require './avatar'
Enemy = require './enemy'

ScheduleTurn = require './action/schedule_turn'

module.exports = class BattleData
  constructor: ({ @party }) ->
    @avatars = _.map @party, (hero, index) ->
      new Avatar
        hero: hero
        position:
          x: 512
          y: 128 + 128 * index
    @monsters = [
      new Enemy(position: { x: 128, y: 128 })
      new Enemy(position: { x: 128, y: 256 })
    ]

  start: ->
    _.each @avatars, (avatar) =>
      GameEvent.trigger 'enqueue', action:
        type: ScheduleTurn
        source: avatar
        executeIn: 0

    _.each @monsters, (enemy) =>
      GameEvent.trigger 'enqueue', action:
        type: ScheduleTurn
        source: enemy
        executeIn: 0
