GameEvent = require 'src/game_event'

AudioManager = require 'src/audio_manager'

Action = require './base'
ScheduleTurn = require './schedule_turn'

module.exports = class Attack extends Action
  @needsTarget: true

  execute: ->
    @retarget() unless @target.alive()

    @effectiveDamage = Math.round(@source.stats.damage * (Math.random() / 2 + 0.75))

    @damageDisplayTTL = 80

    @source.flash(0)
    @target.flash(10)

    AudioManager.playSound _.sample(['low_slash.wav', 'high_slash.wav'])

  update: ->
    if @damageDisplayTTL > 0
      @damageDisplayTTL -= 1
      if @damageDisplayTTL <= 0
        @target.takeDamage @effectiveDamage
        GameEvent.trigger 'finishedAction'
        GameEvent.trigger 'enqueue', action:
          type: ScheduleTurn
          source: @source
          executeIn: 0

  draw: (context) ->
    if @damageDisplayTTL < 60 && @damageDisplayTTL > 0
      context.save()
      context.fillStyle = 'white'
      context.font = '30px manaspaceregular'
      context.globalAlpha = 0.75 * (@damageDisplayTTL / 60) + 0.25
      context.fillText @effectiveDamage,
        @target.position.x + 64,
        @target.position.y - 95 + @damageDisplayTTL
      context.restore()

  retarget: ->
    @target = _.sample \
      _.filter @battle.monsters, (monster) -> monster.alive()
