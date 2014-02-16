class Battle.Action.Spell extends Battle.Action
  @needsSubtype: true
  @needsTarget:  true

  execute: ->
    @effectiveDamage = Math.round(@source.stats.magic * (Math.random() / 2 + 0.75))
    @target.takeDamage @effectiveDamage

    @damageDisplayTTL = 60

  update: ->
    if @damageDisplayTTL
      @damageDisplayTTL -= 1
      if @damageDisplayTTL <= 0
        GameEvent.trigger 'finishedAction'
        GameEvent.trigger 'enqueue', action:
          type: Battle.Action.ScheduleTurn
          source: @source
          executeIn: 0

  draw: (context) ->
    if @damageDisplayTTL
      context.save()
      context.fillStyle = 'red'
      context.font = '30px manaspaceregular'
      context.globalAlpha = 0.75 * (@damageDisplayTTL / 60) + 0.25
      context.fillText @effectiveDamage,
        @target.position.x + 64,
        @target.position.y - 95 + @damageDisplayTTL
      context.restore()
